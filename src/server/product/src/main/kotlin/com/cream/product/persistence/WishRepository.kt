package com.cream.product.persistence

import com.cream.product.model.QWish
import com.cream.product.model.Wish
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport

interface WishRepositoryCustom {
    fun existsWish(userId: Long, productId: Long, size: String): Wish?
}

interface WishRepository : JpaRepository<Wish, Long>, WishRepositoryCustom {
    @Query("INSERT INTO wish (user_id, product_id, size) VALUE (:userId, :productId, :size)", nativeQuery = true)
    @Modifying
    fun createWish(userId: Long, productId: Long, size: String)
    @Query("SELECT COUNT(*) FROM wish WHERE wish.user_id=:userId ", nativeQuery = true)
    fun getWishCount(userId: Long): Int
}

class WishRepositoryImpl :
    QuerydslRepositorySupport(Wish::class.java), WishRepositoryCustom {
    override fun existsWish(
        userId: Long,
        productId: Long,
        size: String
    ): Wish? {
        val wishEntity: QWish = QWish.wish
        return from(wishEntity)
            .where(
                wishEntity.product.id.eq(productId),
                wishEntity.userId.eq(userId),
                wishEntity.size.eq(size)
            )
            .fetchOne()
    }
}