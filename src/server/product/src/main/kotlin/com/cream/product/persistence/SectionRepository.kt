package com.cream.product.persistence

import com.cream.product.model.Section
import org.springframework.data.jpa.repository.JpaRepository

interface SectionRepository : JpaRepository<Section, Long>{
    fun findAllByValid(valid: Boolean): List<Section>
}