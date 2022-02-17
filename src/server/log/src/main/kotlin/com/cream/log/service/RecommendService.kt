package com.cream.log.service

import com.cream.log.persistence.RecommendationRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class RecommendService {

    @Autowired
    lateinit var recommendRepository: RecommendationRepository

    fun getProductsId(
        userId: Long
    ): List<Long> {
        return recommendRepository.findFirstByUserId(userId)?.recommendedItems ?: listOf()
    }
}