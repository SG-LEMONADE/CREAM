package com.cream.product.persistence

import com.cream.product.model.MarketEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface MarketRepository : JpaRepository<MarketEntity, Long> {
    @Query("SELECT * FROM market  WHERE product_id=:productId", nativeQuery = true)
    fun findAllByProductId(productId: Long): List<MarketEntity>
}