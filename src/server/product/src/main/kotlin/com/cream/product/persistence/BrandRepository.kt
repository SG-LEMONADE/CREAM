package com.cream.product.persistence

import com.cream.product.model.Brand
import org.springframework.data.jpa.repository.JpaRepository

interface BrandRepository : JpaRepository<Brand, Long>