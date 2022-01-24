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
}

class WishRepositoryImpl :
    QuerydslRepositorySupport(Wish::class.java), WishRepositoryCustom {
    override fun existsWish(userId: Long, productId: Long, size: String): Wish? {
        val table = QWish.wish
        return from(table)
            .where(table.product.id.eq(productId), table.userId.eq(userId), table.size.eq(size))
            .fetchOne()
    }
}