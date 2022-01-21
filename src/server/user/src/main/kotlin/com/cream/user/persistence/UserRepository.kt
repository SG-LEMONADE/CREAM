package com.cream.user.persistence

import com.cream.user.model.UserEntity
import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository : JpaRepository<UserEntity, Long> {
    fun findOneByEmail(email: String): UserEntity?
    fun existsByEmail(email: String): Boolean
}