package com.cream.user.service

import com.cream.user.constant.UserStatus
import com.cream.user.dto.*
import com.cream.user.error.ErrorCode
import com.cream.user.error.UserCustomException
import com.cream.user.persistence.UserRepository
import com.cream.user.model.User
import com.cream.user.security.TokenProvider
import com.cream.user.utils.UserMailSender

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.util.concurrent.TimeUnit
import javax.transaction.Transactional

@Service
class UserService {
    @Autowired
    lateinit var userRepository: UserRepository

    @Autowired
    lateinit var tokenProvider: TokenProvider

    @Autowired
    lateinit var redisTemplate: StringRedisTemplate

    @Autowired
    lateinit var mailSender: UserMailSender

    var passwordEncoder: PasswordEncoder = BCryptPasswordEncoder()

    fun create(userDTO: RegisterUserDTO): ResponseUserDTO {
        val user = userDTO.toEntity(passwordEncoder)
        if (user.email == "") {
            throw UserCustomException(ErrorCode.INVALID_INPUT_VALUE)
        }
        val email: String = user.email
        if (userRepository.existsByEmail(email)) {
            throw UserCustomException(ErrorCode.DUPLICATED_USER_EMAIL)
        }
        mailSender.sendEmail(email, 0, redisTemplate)
        return ResponseUserDTO(userRepository.save(user))
    }

    fun getValidationToken(
        userDTO: LoginDTO
    ): TokenDTO {
        val user: User = getByCredentials(userDTO.email, userDTO.password, passwordEncoder)

        when (user.status) {
            (UserStatus.NEED_CONFIRM_EMAIL) -> {
                // 이메일 인증 안됐을때
                throw UserCustomException(ErrorCode.USER_EMAIL_NOT_VERIFIED)
            }
            (UserStatus.NEED_CHANGE_PASSWORD) -> {
                // 비밀번호를 반드시 바꾸어야 할 때
                throw UserCustomException(ErrorCode.USER_NEED_TO_CHANGE_PASSWORD)
            }
            (UserStatus.DELETED_USER) -> {
                // 삭제된 유저 일때
                throw UserCustomException(ErrorCode.USER_NOT_FOUND)
            }
        }

        val token: String = tokenProvider.create(user)
        val refreshToken: String = tokenProvider.create(user, isRefresh = true)
        val stringValueOperation = redisTemplate.opsForValue()
        stringValueOperation.set("refresh-${user.id}", refreshToken, 7, TimeUnit.DAYS)
        user.lastLoginDatetime = LocalDateTime.now()
        userRepository.save(user)

        return TokenDTO(user.id, token, refreshToken)
    }

    fun refreshToken(
        tokenDTO: TokenDTO
    ): TokenDTO {
        // 둘다 Bearer 앞에 와야합니다.
        val refreshToken: String = tokenDTO.refreshToken

        val userId = tokenProvider.validateAndGetUserId(refreshToken)

        val stringValueOperation = redisTemplate.opsForValue()
        val storedToken: String? = stringValueOperation.get("refresh-$userId")
        if (storedToken == null || storedToken != refreshToken.substring(7)) {
            throw UserCustomException(ErrorCode.REFRESH_TOKEN_EXPIRED)
        }

        val user = userRepository.getById(userId)
        val newAccessToken = tokenProvider.create(user)
        val newRefreshToken = tokenProvider.create(user, isRefresh = true)

        stringValueOperation.set("refresh-$userId", newRefreshToken, 7, TimeUnit.DAYS)
        return TokenDTO(userId, newAccessToken, newRefreshToken)
    }

    @Transactional
    fun verify(
        email: String,
        hash: String
    ) {
        val stringValueOperation = redisTemplate.opsForValue()
        val storedHash: String? = stringValueOperation.get(email)
        if (storedHash == null || storedHash != hash) {
            throw UserCustomException(ErrorCode.EMAIL_HASH_NOT_VALID)
        }

        val user: User = (userRepository.findOneByEmail(email) ?: throw UserCustomException(ErrorCode.ENTITY_NOT_FOUND))
        user.status = UserStatus.EMAIL_CONFIRMED

        redisTemplate.delete(email)
    }

    fun update(
        userId: Long,
        userUpdateDTO: UpdateUserDTO,
    ): ResponseUserDTO {
        val user = userRepository.findById(userId).orElseThrow()

        if (userUpdateDTO.password != null) {
            if (passwordEncoder.matches(user.password, userUpdateDTO.password))
                throw UserCustomException(ErrorCode.USER_NEW_PASSWORD_SAME_AS_OLD)
            user.password = passwordEncoder.encode(userUpdateDTO.password)
            user.passwordChangedDatetime = LocalDateTime.now()
        }
        if (userUpdateDTO.address != null) user.address = userUpdateDTO.address
        if (userUpdateDTO.shoeSize != null) user.shoeSize = userUpdateDTO.shoeSize
        if (userUpdateDTO.profileImageUrl != null) user.profileImageUrl = userUpdateDTO.profileImageUrl
        if (userUpdateDTO.name != null) user.name = userUpdateDTO.name

        user.updatedAt = LocalDateTime.now()
        return ResponseUserDTO(userRepository.save(user))
    }

    fun getByCredentials(
        email: String,
        password: String,
        encoder: PasswordEncoder
    ): User {
        val user = userRepository.findOneByEmail(email) ?: throw UserCustomException(ErrorCode.USER_EMAIL_NOT_FOUND)
        if (encoder.matches(password, user.password)) return user
        else throw UserCustomException(ErrorCode.USER_PASSWORD_NOT_MATCH)
    }

    fun getMe(
        token: String
    ): ResponseUserDTO {
        val userId = tokenProvider.validateAndGetUserId(token)
        return ResponseUserDTO(userRepository.getById(userId))
    }

    fun logOut(
        token: String
    ) {
        val userId = tokenProvider.validateAndGetUserId(token)
        redisTemplate.delete("refresh-$userId")
    }
}