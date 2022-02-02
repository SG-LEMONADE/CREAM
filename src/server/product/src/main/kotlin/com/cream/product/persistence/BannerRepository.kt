package com.cream.product.persistence

import com.cream.product.model.Banner
import org.springframework.data.jpa.repository.JpaRepository
import java.time.LocalDateTime

interface BannerRepository : JpaRepository<Banner, Long>{
    fun findAllByValid(valid: Boolean): List<Banner>
}