package com.cream.product.persistence

import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.FilterRequestDTO
import com.cream.product.dto.ProductWishDTO
import com.cream.product.model.Product
import com.cream.product.model.QProduct
import com.cream.product.model.QTrade
import com.cream.product.model.QWish
import com.querydsl.core.types.Order
import com.querydsl.core.types.OrderSpecifier
import com.querydsl.core.types.Projections
import com.querydsl.core.types.dsl.BooleanExpression
import com.querydsl.core.types.dsl.Expressions
import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport
import java.time.LocalDateTime

interface ProductRepositoryCustom {
    fun getProducts(offset: Long, limit: Long, sort: String, filter: FilterRequestDTO): List<ProductWishDTO>?
    fun getProductsWithWish(userId: Long?, offset: Long, limit: Long, sort: String, filter: FilterRequestDTO): List<ProductWishDTO>?
    fun getProductWithWish(userId: Long?, productId: Long): ProductWishDTO?
}

interface ProductRepository : JpaRepository<Product, Long>, ProductRepositoryCustom

class ProductRepositoryImpl :
    QuerydslRepositorySupport(Product::class.java), ProductRepositoryCustom {
    @Autowired
    private lateinit var jpaQueryFactory: JPAQueryFactory

    val productEntity: QProduct = QProduct.product
    val wishEntity: QWish = QWish.wish
    val tradeEntity: QTrade = QTrade.trade

    override fun getProductWithWish(
        userId: Long?,
        productId: Long
    ): ProductWishDTO? {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductWishDTO::class.java,
                productEntity, Expressions.stringTemplate("group_concat({0})", wishEntity.size)
            )
        ).from(productEntity)
            .leftJoin(wishEntity).on(wishEntity.product.id.eq(productEntity.id), wishEntity.userId.eq(userId))
            .where(productEntity.id.eq(productId))
            .groupBy(productEntity.id)
            .fetchOne()
    }

    override fun getProducts(
        offset: Long,
        limit: Long,
        sort: String,
        filter: FilterRequestDTO
    ): MutableList<ProductWishDTO>? {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductWishDTO::class.java,
                productEntity,
                Expressions.stringTemplate(""),
                tradeEntity.price.min().`as`("lowestAsk")
            )
        ).from(productEntity)
            .leftJoin(tradeEntity).on(tradeEntity.product.id.eq(productEntity.id),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.requestType.eq(RequestType.BID),
                tradeEntity.validationDateTime.gt(LocalDateTime.now())
            )
            .where(
                eqCategory(filter.category),
                inBrandId(filter.brandId),
                inCollectionId(filter.collectionId),
                likeKeyword(filter.keyWord),
                eqGender(filter.gender)
            )
            .groupBy(productEntity.id)
            .having(
                geoPrice(filter.priceFrom),
                loePrice(filter.priceTo),
            )
            .offset(offset)
            .limit(limit)
            .orderBy(getOrder(sort))
            .fetch()
    }

    override fun getProductsWithWish(
        userId: Long?,
        offset: Long,
        limit: Long,
        sort: String,
        filter: FilterRequestDTO
    ): MutableList<ProductWishDTO>? {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductWishDTO::class.java,
                productEntity,
                Expressions.stringTemplate("group_concat({0})", wishEntity.size),
                tradeEntity.price.min().`as`("lowestAsk")
            )
        ).from(productEntity)
            .leftJoin(wishEntity).on(wishEntity.product.id.eq(productEntity.id), wishEntity.userId.eq(userId))
            .leftJoin(tradeEntity).on(tradeEntity.product.id.eq(productEntity.id),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.requestType.eq(RequestType.BID),
                tradeEntity.validationDateTime.gt(LocalDateTime.now())
            )
            .where(
                eqCategory(filter.category),
                inBrandId(filter.brandId),
                inCollectionId(filter.collectionId),
                likeKeyword(filter.keyWord),
                eqGender(filter.gender),
            )
            .groupBy(productEntity.id)
            .having(
                geoPrice(filter.priceFrom),
                loePrice(filter.priceTo)
            )
            .offset(offset)
            .limit(limit)
            .orderBy(getOrder(sort))
            .fetch()
    }

    private fun eqCategory(category: String?): BooleanExpression? {
        return if (category.isNullOrBlank()) null else productEntity.category.eq(category)
    }

    private fun inBrandId(brandId: String?): BooleanExpression? {
        return if (brandId.isNullOrBlank()) null else productEntity.brand.id.`in`(
            brandId.split(",").map { it.toLong() }
        )
    }

    private fun inCollectionId(collectionId: String?): BooleanExpression? {
        return if (collectionId.isNullOrBlank()) null else productEntity.collection.id.`in`(
            collectionId.split(",").map { it.toLong() }
        )
    }

    private fun geoPrice(price: Int?): BooleanExpression? {
        return if (price == null) null else tradeEntity.price.min().goe(price)
    }

    private fun loePrice(price: Int?): BooleanExpression? {
        return if (price == null) null else tradeEntity.price.min().loe(price)
    }

    private fun likeKeyword(keyWord: String?): BooleanExpression? {
        return if (keyWord.isNullOrBlank()) null else productEntity.translatedName.like(keyWord)
    }

    private fun eqGender(gender: String?): BooleanExpression? {
        return if (gender == null) null else productEntity.gender.eq(gender)
    }

    private fun getOrder(sort: String?): OrderSpecifier<*> {
        val defaultOrder = OrderSpecifier(Order.DESC, productEntity.totalSale)
        when {
            (sort == "released_date") -> {
                return OrderSpecifier(Order.DESC, productEntity.releasedDate)
            }
        }
        return defaultOrder
    }
}