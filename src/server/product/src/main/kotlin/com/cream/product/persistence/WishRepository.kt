package com.cream.product.persistence

import com.cream.product.model.WishEntity
import org.springframework.data.jpa.repository.JpaRepository

interface WishRepository: JpaRepository<WishEntity, Long> {
    fun findOneByProductIdAndUserIdAndSize(userId: Long, productId: Long, size: String): WishEntity?
}