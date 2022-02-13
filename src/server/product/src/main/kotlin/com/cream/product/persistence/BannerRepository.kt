package com.cream.product.persistence

import com.cream.product.model.Banner
import org.springframework.data.jpa.repository.JpaRepository

interface BannerRepository : JpaRepository<Banner, Long> {
    fun findAllByValidIsTrue(): List<Banner>
}