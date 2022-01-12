package com.cream.user.service

import com.cream.user.dto.UpdateUserDTO
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
        if (userEntity.email == null){
            throw RuntimeException("Invalid Email")
        }
        val email: String = userEntity.email
        if (userRepository.existsByEmail(email)){
            throw RuntimeException("Email already exists")
        }
        return userRepository.save(userEntity)
    }

    fun updateUserState(email: String, stateCode: Int){
        var user:UserEntity = (userRepository.findOneByEmail(email) ?: RuntimeException("Email is not exists")) as UserEntity
        user.status = stateCode
        userRepository.save(user)
    }

    fun updateUserLastLoginTime(userEntity: UserEntity){
        userEntity.lastLoginDateTime = LocalDateTime.now()
        userRepository.save(userEntity)
    }

    fun update(userEntity: UserEntity, user: UpdateUserDTO, encoder: PasswordEncoder): UserEntity{
        userEntity.email = user.email
        userEntity.password = encoder.encode(user.password)
        userEntity.name = user.name
        userEntity.address = user.address
        userEntity.shoeSize = user.shoeSize
        userEntity.marriageInfo = user.marriageInfo
        userEntity.updateAt = LocalDateTime.now()
        return userRepository.save(userEntity)
    }

    fun getByCredentials(email: String, password: String, encoder: PasswordEncoder): UserEntity {
        val user = userRepository.findOneByEmail(email) ?: throw RuntimeException("Email is not exists")
        if (encoder.matches(password, user.password)) return user
        else throw RuntimeException("no user")
    }

    fun getById(userId: Long): UserEntity{
        return userRepository.getById(userId)
    }
}