package com.cream.product.service

import com.cream.product.model.WishEntity
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.WishRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class WishService {
    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var wishRepository: WishRepository

    @Transactional
    fun toggleWish(userId: Long, productId: Long, size: String) {
        val wish = wishRepository.findOneByProductIdAndUserIdAndSize(userId, productId, size)
        val product = productRepository.getById(productId)
        if (wish == null) {
            wishRepository.save(WishEntity(product = product, userId = userId, size = size))
        } else {
            wishRepository.delete(wish)
        }
    }
}