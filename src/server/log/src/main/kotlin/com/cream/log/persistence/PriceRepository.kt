package com.cream.log.persistence

import com.cream.log.model.Price
import org.springframework.data.mongodb.repository.MongoRepository
import java.time.LocalDate

interface PriceRepository : MongoRepository<Price, Long> {
    fun findAllByProductId(productId: Long): List<Price>
    fun findOneByCreatedDateAndProductId(createdDate: LocalDate, productId: Long): Price?
}