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
    lateinit var wishRepository: WishRepository

    fun toggleWish(userId: Long, productId: Long, size: String): String{
        val wish = wishRepository.existsWish(userId, productId, size)
        return if (wish != null) {
            wishRepository.delete(wish)
            "deleted"
        } else {
            wishRepository.createWish(userId, productId, size)
            "created"
        }
    }
}