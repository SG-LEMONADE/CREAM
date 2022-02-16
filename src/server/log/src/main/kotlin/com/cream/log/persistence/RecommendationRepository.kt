package com.cream.log.persistence

import com.cream.log.model.RecommendItem
import org.springframework.data.mongodb.repository.MongoRepository

interface RecommendationRepository : MongoRepository<RecommendItem, String> {
    fun findFirstByUserId(userId: Long): RecommendItem?
}