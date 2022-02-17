package com.cream.log.persistence

import com.cream.log.model.Price
import org.springframework.data.mongodb.repository.MongoRepository
import java.time.LocalDate

interface PriceRepository : MongoRepository<Price, Long> {
    fun findAllByProductIdAndSize(productId: Long, size: String?): List<Price>
    fun findOneByCreatedDateAndProductIdAndSize(createdDate: LocalDate, productId: Long, size: String?): Price?
}