package com.cream.product.persistence

import com.cream.product.model.Collection
import org.springframework.data.jpa.repository.JpaRepository

interface CollectionRepository : JpaRepository<Collection, Long>