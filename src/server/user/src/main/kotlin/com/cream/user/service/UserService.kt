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

    fun create(
        userDTO: RegisterUserDTO
    ): ResponseUserDTO {
        // 유저 생성
        val user = userDTO.toEntity(passwordEncoder)

        val email: String = user.email
        if (userRepository.existsByEmail(email)) {
            // 중복되는 이메일이 있을 경우
            throw UserCustomException(ErrorCode.DUPLICATED_USER_EMAIL)
        }

        mailSender.sendEmail(email, 0, redisTemplate)
        return ResponseUserDTO(userRepository.save(user))
    }

    fun getValidationToken(
        userDTO: LoginDTO
    ): TokenDTO {
        // 유저 로그인 시 토큰 값 반환
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

        // 리프레시 토큰 redis 저장
        val stringValueOperation = redisTemplate.opsForValue()
        stringValueOperation.set("refresh-${user.id}", refreshToken, 7, TimeUnit.DAYS)

        user.lastLoginDatetime = LocalDateTime.now()
        userRepository.save(user)

        return TokenDTO(user.id, token, refreshToken)
    }

    fun refreshToken(
        tokenDTO: TokenDTO
    ): TokenDTO {
        // "Bearer "가 토큰 값 앞에 와야합니다.
        val refreshToken: String = tokenDTO.refreshToken

        val userId = tokenProvider.validateAndGetUserId(refreshToken)

        val stringValueOperation = redisTemplate.opsForValue()
        val storedToken: String? = stringValueOperation.get("refresh-$userId")
        //refresh token 유효성 확인
        if (storedToken == null || storedToken != refreshToken.substring(7)) {
            throw UserCustomException(ErrorCode.REFRESH_TOKEN_EXPIRED)
        }

        val user = userRepository.getById(userId)
        val newAccessToken = tokenProvider.create(user)
        val newRefreshToken = tokenProvider.create(user, isRefresh = true)

        // refresh token 업데이트
        stringValueOperation.set("refresh-$userId", newRefreshToken, 7, TimeUnit.DAYS)
        return TokenDTO(userId, newAccessToken, newRefreshToken)
    }

    @Transactional
    fun verify(
        email: String,
        hash: String
    ) {
        // 유저 이메일 인증 hash 값 확인
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
        // 유저 업데이트
        val user = userRepository.findById(userId).orElseThrow()

        if (userUpdateDTO.password != null) {
            // 비밀번호 변경 시
            if (passwordEncoder.matches(user.password, userUpdateDTO.password))
                // 전에 사용했던 비밀번호와 같을 때 변경 불가
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

    fun getMe(
        token: String
    ): ResponseUserDTO {
        // 내 정보 반환
        val userId = tokenProvider.validateAndGetUserId(token)
        return ResponseUserDTO(userRepository.getById(userId))
    }

    fun logout(
        token: String
    ) {
        val userId = tokenProvider.validateAndGetUserId(token)
        // 로그아웃 시 refresh token 삭제
        redisTemplate.delete("refresh-$userId")
    }

    private fun getByCredentials(
        email: String,
        password: String,
        encoder: PasswordEncoder
    ): User {
        val user = userRepository.findOneByEmail(email) ?: throw UserCustomException(ErrorCode.USER_EMAIL_NOT_FOUND)
        if (encoder.matches(password, user.password)) return user
        else throw UserCustomException(ErrorCode.USER_PASSWORD_NOT_MATCH)
    }
}