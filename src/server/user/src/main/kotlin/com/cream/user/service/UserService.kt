package com.cream.user.service

import com.cream.user.dto.UpdateUserDTO
import com.cream.user.error.ErrorCode
import com.cream.user.error.UserCustomException
import com.cream.user.persistence.UserRepository
import com.cream.user.model.UserEntity

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
class UserService {
    @Autowired
    lateinit var userRepository: UserRepository

    fun create(userEntity: UserEntity): UserEntity{
        if (userEntity.email == null || userEntity.email == ""){
            throw UserCustomException(ErrorCode.INVALID_INPUT_VALUE)
        }
        val email: String = userEntity.email
        if (userRepository.existsByEmail(email)){
            throw UserCustomException(ErrorCode.DUPLICATED_USER_EMAIL)
        }
        return userRepository.save(userEntity)
    }

    fun updateUserState(email: String, stateCode: Int){
        var user: UserEntity = (userRepository.findOneByEmail(email) ?: throw UserCustomException(ErrorCode.ENTITY_NOT_FOUND))
        user.status = stateCode
        userRepository.save(user)
    }

    fun updateUserLastLoginTime(userEntity: UserEntity){
        userEntity.lastLoginDateTime = LocalDateTime.now()
        userRepository.save(userEntity)
    }

    fun update(userEntity: UserEntity, user: UpdateUserDTO, encoder: PasswordEncoder): UserEntity{
        val originalPassword = userEntity.password
        userEntity.email = user.email
        userEntity.password = encoder.encode(user.password)
        userEntity.name = user.name
        userEntity.address = user.address
        userEntity.shoeSize = user.shoeSize
        userEntity.updateAt = LocalDateTime.now()
        if (originalPassword != userEntity.password){
            userEntity.passwordChangedDateTime = LocalDateTime.now()
        }
        return userRepository.save(userEntity)
    }

    fun getByCredentials(email: String, password: String, encoder: PasswordEncoder): UserEntity {
        val user = userRepository.findOneByEmail(email) ?: throw UserCustomException(ErrorCode.USER_EMAIL_NOT_FOUND)
        if (encoder.matches(password, user.password)) return user
        else throw UserCustomException(ErrorCode.USER_PASSWORD_NOT_MATCH)
    }

    fun getById(userId: Long): UserEntity{
        return userRepository.getById(userId)
    }
}