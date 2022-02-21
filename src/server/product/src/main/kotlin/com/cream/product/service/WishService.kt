package com.cream.product.service

import com.cream.product.client.LogServiceClient
import com.cream.product.dto.UserLogDTO
import com.cream.product.error.BaseException
import com.cream.product.error.ErrorCode
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.WishRepository
import com.fasterxml.jackson.databind.ObjectMapper
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.Lock
import org.springframework.stereotype.Service
import javax.persistence.LockModeType
import javax.transaction.Transactional

@Service
class WishService {
    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var wishRepository: WishRepository

    @Autowired
    lateinit var logServiceClient: LogServiceClient

    private val log = LoggerFactory.getLogger(javaClass)

    @Transactional
    @Lock(value = LockModeType.PESSIMISTIC_READ)
    fun toggleWish(
        userId: Long,
        productId: Long,
        size: String
    ) {
        val wish = wishRepository.existsWish(userId, productId, size)

        val product = productRepository.findById(productId).orElseThrow()
        if (!ObjectMapper().readValue(product.sizes, ArrayList::class.java).contains(size)) {
            throw BaseException(ErrorCode.INVALID_SIZE_FOR_PRODUCT)
        }

        if (wish != null) {
            wishRepository.delete(wish)
            product.wishCnt -= 1
        } else {
            wishRepository.createWish(userId, productId, size)
            product.wishCnt += 1
            logServiceClient.insertUserLogData(UserLogDTO(userId, productId, 2))
        }
    }
}