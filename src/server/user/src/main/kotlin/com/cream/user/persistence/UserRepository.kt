package com.cream.user.persistence

import com.cream.user.model.User
import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository : JpaRepository<User, Long> {
    fun findOneByEmail(email: String): User?
    fun existsByEmail(email: String): Boolean
}