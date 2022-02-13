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
import com.querydsl.core.types.dsl.NumberPath
import com.querydsl.jpa.JPAExpressions
import com.querydsl.jpa.JPQLQuery
import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport
import java.time.LocalDateTime

interface ProductRepositoryCustom {
    fun getProducts(offset: Long, limit: Long, sort: String?, filter: FilterRequestDTO): List<ProductPriceWishDTO>
    fun getProductsWithWish(userId: Long, offset: Long, limit: Long, sort: String?, filter: FilterRequestDTO): List<ProductPriceWishDTO>

    fun getProduct(productId: Long, size: String?): ProductPriceWishDTO
    fun getProductWithWish(userId: Long, productId: Long, size: String?): ProductPriceWishDTO

    fun getProductPricesBySize(productId: Long, requestType: RequestType): List<ProductPriceBySizeDTO>?
    fun getProductsByWish(userId: Long, offset: Long, limit: Long): List<WishedProductDTO>
}

interface ProductRepository : JpaRepository<Product, Long>, ProductRepositoryCustom

class ProductRepositoryImpl :
    QuerydslRepositorySupport(Product::class.java), ProductRepositoryCustom {

    @Autowired
    private lateinit var jpaQueryFactory: JPAQueryFactory

    private val productEntity: QProduct = QProduct.product
    private val wishEntity: QWish = QWish.wish
    private val tradeEntity: QTrade = QTrade.trade

    override fun getProducts(
        offset: Long,
        limit: Long,
        sort: String?,
        filter: FilterRequestDTO
    ): List<ProductPriceWishDTO> {
        // 비 로그인시 상품 목록 반환
        return jpaQueryFactory.select(
            QProductPriceWishDTO(
                productEntity,
                Expressions.asString(""), // 비로그인 했기에 찜 목록은 null 값이 들어갑니다.
                Expressions.`as`(lowestAskQuery(null), "lowestAsk"), // 최저 판매 가격
                Expressions.`as`(highestBidQuery(null), "highestBid"), // 최고 구매 가격
                Expressions.`as`(premiumPriceQuery(null), "premiumPrice") // 직전 거래 가격과 상품 발매 가격의 차
            )
        ).from(productEntity)
            .where(
                eqCategory(filter.category),
                inBrandId(filter.brandId),
                inCollectionId(filter.collectionId),
                likeKeyword(filter.keyword),
                eqGender(filter.gender),
            )
            .groupBy(productEntity.id)
            .having(
                geoPrice(filter.priceFrom),
                loePrice(filter.priceTo),
            )
            .offset(offset)
            .limit(limit)
            .orderBy(getOrder(sort), OrderSpecifier(Order.ASC, productEntity.id))
            .fetch()
    }

    override fun getProductsWithWish(
        userId: Long,
        offset: Long,
        limit: Long,
        sort: String?,
        filter: FilterRequestDTO
    ): List<ProductPriceWishDTO> {
        // 로그인 시 상품 목록 + 내 사이즈 별 찜 여부 반환
        return jpaQueryFactory.select(
            QProductPriceWishDTO(
                productEntity,
                // 유저가 찜 한 사이즈들을 종합해 "230,240" 문자열 형식으로 반환 합니다.
                Expressions.stringTemplate("group_concat({0})", wishEntity.size),
                Expressions.`as`(lowestAskQuery(null), "lowestAsk"),
                Expressions.`as`(highestBidQuery(null), "highestBid"),
                Expressions.`as`(premiumPriceQuery(null), "premiumPrice")
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
                likeKeyword(filter.keyword),
                eqGender(filter.gender),
            )
            .groupBy(productEntity.id)
            .having(
                geoPrice(filter.priceFrom),
                loePrice(filter.priceTo),
            )
            .offset(offset)
            .limit(limit)
            .orderBy(getOrder(sort), OrderSpecifier(Order.ASC, productEntity.id))
            .fetch()
    }

    override fun getProduct(
        productId: Long,
        size: String?
    ): ProductPriceWishDTO {
        // 비 로그인 시에 상품 하나의 정보
        return jpaQueryFactory.select(
            QProductPriceWishDTO(
                productEntity,
                Expressions.asString(""),
                lowestAskQuery(size), // 최저 판매 가격 - 리스트와 다르게 조건문에서 사용될 일이 없기 때문에 as를 사용하지 않았습니다.
                highestBidQuery(size), // 최고 구매 가격
                premiumPriceQuery(size) // 직전 거래 가격과 상품 발매 가격차
            )
        ).from(productEntity)
            .where(productEntity.id.eq(productId))
            .fetchFirst()
    }

    override fun getProductWithWish(
        userId: Long,
        productId: Long,
        size: String?
    ): ProductPriceWishDTO {
        // 로그인 시에 상품의 어떤 사이즈를 찜했는지 같이 문자열 형태로 반환해 줍니다.
        return jpaQueryFactory.select(
            QProductPriceWishDTO(
                productEntity,
                //  ex) "270,280,300"
                Expressions.stringTemplate("group_concat({0})", wishEntity.size),
                lowestAskQuery(size),
                highestBidQuery(size),
                premiumPriceQuery(size)
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
        // 상품의 최저, 최고 가격들을 사이즈별로 반환해 줍니다.
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

    override fun getProductsByWish(
        userId: Long,
        offset: Long,
        limit: Long,
    ): List<WishedProductDTO> {
        // 찜한 상품들의 정보를 반환합니다.
        return jpaQueryFactory.select(
            QWishedProductDTO(
                wishEntity.product.id,
                wishEntity.product.brandName,
                wishEntity.product.originalName,
                wishEntity.size,
                wishEntity.product.imageUrls,
                wishEntity.product.backgroundColor,
                tradeEntity.price.min()
            )
        ).from(wishEntity)
            .leftJoin(tradeEntity)
            .on(
                tradeEntity.product.id.eq(wishEntity.product.id),
                tradeEntity.size.eq(wishEntity.size),
                tradeEntity.requestType.eq(RequestType.ASK)
            )
            .where(wishEntity.userId.eq(userId))
            .groupBy(wishEntity.size, wishEntity.product.id)
            .orderBy(OrderSpecifier(Order.DESC, wishEntity.id.min()))
            .offset(offset)
            .limit(limit)
            .fetch()
    }

    // alias 로 사용해 주기 위해 먼저 선언해줍니다.
    val lowestAsk: NumberPath<Int> = Expressions.numberPath(Int::class.java, "lowestAsk") // 최저 판매가
    val premiumPrice: NumberPath<Int> = Expressions.numberPath(Int::class.java, "premiumPrice") // 직전 거래 - 상품 발매 가격
    val highestBid: NumberPath<Int> = Expressions.numberPath(Int::class.java, "highestBid")// 최고 구매가

    // 아래는 가격 정보를 위한 스칼라 서브쿼리와 검색 필터를 위한 함수들입니다.
    private fun lowestAskQuery(
        size: String?
    ): JPQLQuery<Int> {
        return JPAExpressions
            .select(tradeEntity.price.min())
            .from(tradeEntity)
            .where(
                tradeEntity.requestType.eq(RequestType.ASK),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.product.id.eq(productEntity.id),
                tradeEntity.validationDateTime.gt(LocalDateTime.now()),
                eqSize(size)
            )
    }

    private fun premiumPriceQuery(
        size: String?
    ): JPQLQuery<Int> {
        return JPAExpressions
            .select(tradeEntity.price.min().subtract(productEntity.originalPrice))
            .from(tradeEntity)
            .where(
                tradeEntity.requestType.eq(RequestType.ASK),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.product.id.eq(productEntity.id),
                tradeEntity.validationDateTime.gt(LocalDateTime.now()),
                eqSize(size)
            )
    }

    private fun highestBidQuery(
        size: String?
    ): JPQLQuery<Int> {
        return JPAExpressions
            .select(tradeEntity.price.max())
            .from(tradeEntity)
            .where(
                tradeEntity.requestType.eq(RequestType.BID),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.product.id.eq(productEntity.id),
                tradeEntity.validationDateTime.gt(LocalDateTime.now()),
                eqSize(size)
            )
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
        // 브랜드 id 검색
        return if (brandId.isNullOrBlank()) null else productEntity.brand.id.`in`(
            brandId.split(",").map { it.toLong() }
        )
    }

    private fun inCollectionId(collectionId: String?): BooleanExpression? {
        // collection id 검색
        return if (collectionId.isNullOrBlank()) null else productEntity.collection.id.`in`(
            collectionId.split(",").map { it.toLong() }
        )
    }

    private fun geoPrice(price: Int?): BooleanExpression? {
        return if (price == null) null else lowestAskQuery(null).goe(price)
    }

    private fun loePrice(price: Int?): BooleanExpression? {
        return if (price == null) null else lowestAskQuery(null).loe(price)
    }

    private fun likeKeyword(keyWord: String?): BooleanExpression? {
        return if (keyWord.isNullOrBlank()) null else productEntity.translatedName.contains(keyWord).or(productEntity.originalName.contains(keyWord))
    }

    private fun eqGender(gender: String?): BooleanExpression? {
        return if (gender == null) null else productEntity.gender.eq(gender)
    }

    private fun getOrder(sort: String?): OrderSpecifier<*> {
        // 순서를 결정합니다.
        val defaultOrder = OrderSpecifier(Order.DESC, productEntity.totalSale)
        when (sort) {
            ("released_date") -> {
                return OrderSpecifier(Order.DESC, productEntity.releasedDate)
            }
            ("lowest_ask") -> {
                return OrderSpecifier(Order.ASC, lowestAsk).nullsLast()
            }
            ("highest_bid") -> {
                return OrderSpecifier(Order.DESC, highestBid).nullsLast()
            }
            ("premium_price") -> {
                return OrderSpecifier(Order.DESC, premiumPrice).nullsLast()
            }
        }
        return defaultOrder
    }
}