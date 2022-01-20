package com.cream.product.service

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
    fun toggleWish(userId: Long, productId: Long, size: String){
        val wish = wishRepository.existsWish(userId, productId, size)
        val product = productRepository.findById(productId).orElseThrow()
        if (wish != null) {
            wishRepository.delete(wish)
            product.wishCnt -= 1
        } else {
            wishRepository.createWish(userId, productId, size)
            product.wishCnt += 1
        }
    }
}