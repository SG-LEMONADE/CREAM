package com.cream.user.service

import com.cream.user.dto.*
import com.cream.user.error.ErrorCode
import com.cream.user.error.UserCustomException
import com.cream.user.persistence.UserRepository
import com.cream.user.model.UserEntity
import com.cream.user.security.TokenProvider
import com.cream.user.utils.MailSender

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
    lateinit var mailSender: MailSender

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
        mailSender.sendEmail(email, 0)
        return ResponseUserDTO(userRepository.save(user))
    }

    fun getValidationToken(
        userDTO: LoginDTO
    ): TokenDTO {
        val user: UserEntity = getByCredentials(userDTO.email, userDTO.password, passwordEncoder)

        when {
            (user.status == 0) -> {
                // 이메일 인증 안됐을때
                throw UserCustomException(ErrorCode.USER_EMAIL_NOT_VERIFIED)
            }
            (user.status == 1) -> {
                // 비밀번호를 반드시 바꾸어야 할 때
                throw UserCustomException(ErrorCode.USER_NEED_TO_CHANGE_PASSWORD)
            }
            (user.status == 3) -> {
                // 삭제된 유저 일때
                throw UserCustomException(ErrorCode.USER_NOT_FOUND)
            }
        }

        val token: String = tokenProvider.create(user)
        val refreshToken: String = tokenProvider.create(user, isRefresh = true)
        val stringValueOperation = redisTemplate.opsForValue()
        stringValueOperation.set("refresh-${user.id}", refreshToken, 7, TimeUnit.DAYS)
        updateUserLastLoginTime(user)

        return TokenDTO(user.id, token, refreshToken)
    }

    fun refreshToken(
        tokenDTO: TokenDTO
    ): TokenDTO {
        // 둘다 Bearer 앞에 와야합니다.
        val accessToken: String = tokenDTO.accessToken
        val refreshToken: String = tokenDTO.refreshToken

        val userId = tokenProvider.validateAndGetUserId(refreshToken)
        if (tokenProvider.validateAndGetUserId(accessToken) != userId) {
            // 엑세스 토큰과 리프레시 토큰이 다른 사람일때
            throw UserCustomException(ErrorCode.REFRESH_TOKEN_NOT_VALID)
        }

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

    fun updateUserState(
        email: String,
        stateCode: Int
    ) {
        val user: UserEntity = (userRepository.findOneByEmail(email) ?: throw UserCustomException(ErrorCode.ENTITY_NOT_FOUND))
        user.status = stateCode
        userRepository.save(user)
    }

    fun verify(
        email: String,
        hash: String
    ) {
        val stringValueOperation = redisTemplate.opsForValue()
        val storedHash: String? = stringValueOperation.get(email)
        if (storedHash == null || storedHash != hash) {
            throw UserCustomException(ErrorCode.EMAIL_HASH_NOT_VALID)
        }
        updateUserState(email, 2)
        redisTemplate.delete(email)
    }

    @Transactional
    fun updateUserLastLoginTime(
        userEntity: UserEntity
    ) {
        userEntity.lastLoginDateTime = LocalDateTime.now()
    }

    fun update(
        userId: Long,
        userUpdateDTO: UpdateUserDTO,
    ): ResponseUserDTO {
        val user = userRepository.findById(userId).orElseThrow()

        if (!passwordEncoder.matches(user.password, userUpdateDTO.password)) {
            user.passwordChangedDateTime = LocalDateTime.now()
        }
        user.email = userUpdateDTO.email
        user.password = passwordEncoder.encode(userUpdateDTO.password)
        user.name = userUpdateDTO.name
        user.address = userUpdateDTO.address
        user.shoeSize = userUpdateDTO.shoeSize
        user.age = userUpdateDTO.age
        user.gender = userUpdateDTO.gender
        user.profileImageUrl = userUpdateDTO.profileImageUrl
        user.updateAt = LocalDateTime.now()
        return ResponseUserDTO(userRepository.save(user))
    }

    fun getByCredentials(
        email: String,
        password: String,
        encoder: PasswordEncoder
    ): UserEntity {
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