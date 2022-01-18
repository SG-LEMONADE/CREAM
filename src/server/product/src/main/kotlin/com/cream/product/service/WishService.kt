package com.cream.product.service

import com.cream.product.persistence.WishRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

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