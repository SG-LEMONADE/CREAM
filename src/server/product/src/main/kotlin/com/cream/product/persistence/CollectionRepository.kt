package com.cream.product.persistence

import com.cream.product.model.CollectionEntity
import org.springframework.data.jpa.repository.JpaRepository

interface CollectionRepository : JpaRepository<CollectionEntity, Long>