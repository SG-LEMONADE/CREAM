package com.cream.product.persistence

import com.cream.product.model.TagEntity
import org.springframework.data.jpa.repository.JpaRepository

interface TagRepository: JpaRepository<TagEntity, Long> {
}