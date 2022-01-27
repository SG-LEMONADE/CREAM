package com.cream.product.persistence

import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.productDTO.*
import com.cream.product.model.*
import com.querydsl.core.types.Order
import com.querydsl.core.types.OrderSpecifier
import com.querydsl.core.types.Projections
import com.querydsl.core.types.dsl.BooleanExpression
import com.querydsl.core.types.dsl.Expressions
import com.querydsl.core.types.dsl.NumberExpression
import com.querydsl.jpa.JPAExpressions
import com.querydsl.jpa.JPQLQuery
import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport
import java.time.LocalDateTime

interface ProductRepositoryCustom {
    fun getProducts(offset: Long, limit: Long, sort: String?, filter: FilterRequestDTO): List<ProductPriceDTO>
    fun getProductsWithWish(userId: Long, offset: Long, limit: Long, sort: String?, filter: FilterRequestDTO): List<ProductPriceWishDTO>

    fun getProduct(productId: Long): ProductPriceDTO
    fun getProductWithWish(userId: Long, productId: Long): ProductPriceWishDTO

    fun getProductPricesBySize(productId: Long, requestType: RequestType): List<ProductPriceBySizeDTO>?
    fun getProductSizePriceByRequestType(productId: Long, size: String?, requestType: RequestType): ProductPriceByRequestTypeDTO?
    fun getLastTrade(productId: Long, size: String?): Trade?

    fun getProductsByWish(userId: Long, offset: Long, limit: Long): List<ProductPriceWishDTO>
}

interface ProductRepository : JpaRepository<Product, Long>, ProductRepositoryCustom

class ProductRepositoryImpl :
    QuerydslRepositorySupport(Product::class.java), ProductRepositoryCustom {

    @Autowired
    private lateinit var jpaQueryFactory: JPAQueryFactory

    private val productEntity: QProduct = QProduct.product
    private val wishEntity: QWish = QWish.wish
    private val tradeEntity: QTrade = QTrade.trade

    private val lowestAskQuery: JPQLQuery<Int> = JPAExpressions
        .select(tradeEntity.price.min())
        .from(tradeEntity)
        .where(
            tradeEntity.requestType.eq(RequestType.ASK),
            tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
            tradeEntity.product.id.eq(productEntity.id),
            tradeEntity.validationDateTime.gt(LocalDateTime.now())
        )

    override fun getProducts(
        offset: Long,
        limit: Long,
        sort: String?,
        filter: FilterRequestDTO
    ): List<ProductPriceDTO> {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceDTO::class.java,
                productEntity,
                lowestAskQuery
            )
        ).from(productEntity)
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
                loePrice(filter.priceTo),
            )
            .offset(offset)
            .limit(limit)
            .orderBy(getOrder(sort))
            .fetch()
    }

    override fun getProductsWithWish(
        userId: Long,
        offset: Long,
        limit: Long,
        sort: String?,
        filter: FilterRequestDTO
    ): MutableList<ProductPriceWishDTO> {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceWishDTO::class.java,
                productEntity,
                Expressions.stringTemplate("group_concat({0})", wishEntity.size),
                lowestAskQuery
            )
        ).from(productEntity)
            .leftJoin(wishEntity).on(
                wishEntity.product.id.eq(productEntity.id),
                wishEntity.userId.eq(userId)
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
                loePrice(filter.priceTo),
            )
            .offset(offset)
            .limit(limit)
            .orderBy(getOrder(sort))
            .fetch()
    }

    override fun getProduct(
        productId: Long
    ): ProductPriceDTO {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceDTO::class.java,
                productEntity,
                lowestAskQuery
            )
        ).from(productEntity)
            .where(productEntity.id.eq(productId))
            .fetchFirst()
    }

    override fun getProductWithWish(
        userId: Long,
        productId: Long
    ): ProductPriceWishDTO {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceWishDTO::class.java,
                productEntity,
                Expressions.stringTemplate("group_concat({0})", wishEntity.size),
                lowestAskQuery
            )
        ).from(productEntity)
            .leftJoin(wishEntity).on(
                wishEntity.product.id.eq(productEntity.id),
                wishEntity.userId.eq(userId)
            )
            .where(productEntity.id.eq(productId))
            .groupBy(productEntity.id)
            .fetchFirst()
    }

    override fun getProductPricesBySize(
        productId: Long,
        requestType: RequestType
    ): MutableList<ProductPriceBySizeDTO>? {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceBySizeDTO::class.java,
                tradeEntity.size,
                lowestAskOrHighestBid(requestType)
            )
        )
            .from(tradeEntity)
            .where(
                tradeEntity.product.id.eq(productId),
                tradeEntity.requestType.eq(requestType),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.validationDateTime.gt(LocalDateTime.now())
            )
            .groupBy(tradeEntity.size)
            .fetch()
    }

    override fun getProductSizePriceByRequestType(
        productId: Long,
        size: String?,
        requestType: RequestType
    ): ProductPriceByRequestTypeDTO? {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceByRequestTypeDTO::class.java,
                tradeEntity.requestType,
                lowestAskOrHighestBid(requestType)
            )
        )
            .from(tradeEntity)
            .where(
                tradeEntity.product.id.eq(productId),
                tradeEntity.requestType.eq(requestType),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.validationDateTime.gt(LocalDateTime.now()),
                eqSize(size)
            )
            .fetchFirst()
    }

    override fun getLastTrade(
        productId: Long,
        size: String?
    ): Trade? {
        return from(tradeEntity)
            .where(
                tradeEntity.product.id.eq(productId),
                tradeEntity.tradeStatus.eq(TradeStatus.COMPLETED),
                eqSize(size)
            )
            .orderBy(OrderSpecifier(Order.DESC, tradeEntity.updatedAt))
            .fetchOne()
    }

    override fun getProductsByWish(
        userId: Long,
        offset: Long,
        limit: Long,
    ): List<ProductPriceWishDTO> {
        return jpaQueryFactory.select(
            Projections.constructor(
                ProductPriceWishDTO::class.java,
                productEntity,
                wishEntity.size,
                lowestAskQuery,
            )
        ).from(productEntity)
            .join(wishEntity)
            .on(wishEntity.product.id.eq(productEntity.id))
            .where(wishEntity.userId.eq(userId))
            .offset(offset)
            .limit(limit)
            .fetch()
    }

    private fun lowestAskOrHighestBid(requestType: RequestType): NumberExpression<Int>? {
        if (requestType == RequestType.ASK) {
            return tradeEntity.price.min()
        }
        return tradeEntity.price.max()
    }

    private fun eqSize(size: String?): BooleanExpression? {
        return if (size.isNullOrBlank()) null else tradeEntity.size.eq(size)
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
        return if (price == null) null else lowestAskQuery.goe(price)
    }

    private fun loePrice(price: Int?): BooleanExpression? {
        return if (price == null) null else lowestAskQuery.loe(price)
    }

    private fun likeKeyword(keyWord: String?): BooleanExpression? {
        return if (keyWord.isNullOrBlank()) null else productEntity.translatedName.contains(keyWord).or(productEntity.originalName.contains(keyWord))
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