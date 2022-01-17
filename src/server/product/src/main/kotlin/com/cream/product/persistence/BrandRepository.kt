package com.cream.product.persistence

import com.cream.product.model.BrandEntity
import org.springframework.data.jpa.repository.JpaRepository

interface BrandRepository: JpaRepository<BrandEntity, Long> {
}