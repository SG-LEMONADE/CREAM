package com.cream.product.persistence

import com.cream.product.model.MarketEntity
import org.springframework.data.jpa.repository.JpaRepository

interface MarketRepository: JpaRepository<MarketEntity, Long> {
    fun findAllByProductId(productId: Long): List<MarketEntity>
}