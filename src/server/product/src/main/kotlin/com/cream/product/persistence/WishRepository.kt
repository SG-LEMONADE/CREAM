package com.cream.product.persistence

import com.cream.product.model.QWishEntity
import com.cream.product.model.WishEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport
import javax.transaction.Transactional

interface WishRepositoryCustom{
    fun existsWish(userId: Long, productId: Long, size: String): WishEntity?
}

interface WishRepository: JpaRepository<WishEntity, Long>, WishRepositoryCustom {
    @Query("INSERT INTO wish (user_id, product_id, size) VALUE (:userId, :productId, :size)", nativeQuery = true)
    @Modifying
    fun createWish(userId: Long, productId: Long, size: String)
}

class WishRepositoryImpl :
        QuerydslRepositorySupport(WishEntity::class.java), WishRepositoryCustom {
            override fun existsWish(userId: Long, productId: Long, size: String): WishEntity?{
                val table = QWishEntity.wishEntity
                return from(table)
                    .where(table.product.id.eq(productId), table.userId.eq(userId), table.size.eq(size))
                    .fetchOne()
            }
        }