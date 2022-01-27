package com.cream.product.persistence

import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.tradeDTO.TradeBySizeCountDTO
import com.cream.product.model.QTrade
import com.cream.product.model.Trade
import com.querydsl.core.types.Order
import com.querydsl.core.types.OrderSpecifier
import com.querydsl.core.types.Projections
import com.querydsl.core.types.dsl.BooleanExpression
import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport
import java.time.LocalDateTime

interface TradeRepositoryCustom {
    fun findFirstTrade(productId: Long, size: String, requestType: RequestType): Trade
    fun findAllByPageAndStatus(userId: Long, offset: Long, limit: Long, requestType: RequestType, tradeStatus: TradeStatus): List<Trade>
    fun findByProductIdWithCount(size: String?, productId: Long, requestType: RequestType): List<TradeBySizeCountDTO>
    fun findByProductIdCompleted(productId: Long): List<Trade>
}

interface TradeRepository : JpaRepository<Trade, Long>, TradeRepositoryCustom

class TradeRepositoryImpl :
    QuerydslRepositorySupport(Trade::class.java), TradeRepositoryCustom {

    @Autowired
    private lateinit var jpaQueryFactory: JPAQueryFactory

    private var tradeEntity: QTrade = QTrade.trade

    override fun findFirstTrade(
        productId: Long,
        size: String,
        requestType: RequestType
    ): Trade {
        return jpaQueryFactory
            .select(tradeEntity)
            .from(tradeEntity)
            .where(
                tradeEntity.product.id.eq(productId),
                tradeEntity.size.eq(size),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                tradeEntity.validationDateTime.gt(LocalDateTime.now()),
                tradeEntity.requestType.eq(requestType)
            )
            .orderBy(eqRequestType(requestType), OrderSpecifier(Order.ASC, tradeEntity.updatedAt))
            .fetchFirst()
    }

    override fun findAllByPageAndStatus(
        userId: Long,
        offset: Long,
        limit: Long,
        requestType: RequestType,
        tradeStatus: TradeStatus
    ): List<Trade> {
        return jpaQueryFactory
            .select(tradeEntity)
            .from(tradeEntity)
            .where(
                tradeEntity.requestType.eq(requestType),
                tradeEntity.tradeStatus.eq(tradeStatus),
                tradeEntity.userId.eq(userId).or(tradeEntity.counterpartUserId.eq(userId))
            )
            .offset(offset)
            .limit(limit)
            .fetch()
    }

    override fun findByProductIdWithCount(
        size: String?,
        productId: Long,
        requestType: RequestType
    ): List<TradeBySizeCountDTO> {
        return jpaQueryFactory
            .select(
                Projections.constructor(
                    TradeBySizeCountDTO::class.java,
                    tradeEntity.size,
                    tradeEntity.price,
                    tradeEntity.count()
                )
            )
            .from(tradeEntity)
            .where(
                tradeEntity.product.id.eq(productId),
                tradeEntity.requestType.eq(requestType),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                eqSize(size)
            )
            .groupBy(
                tradeEntity.price,
                tradeEntity.size
            )
            .orderBy(OrderSpecifier(Order.ASC, tradeEntity.price))
            .limit(5)
            .fetch()
    }

    override fun findByProductIdCompleted(
        productId: Long
    ): List<Trade> {
        return jpaQueryFactory
            .select(tradeEntity)
            .from(tradeEntity)
            .where(
                tradeEntity.tradeStatus.eq(TradeStatus.COMPLETED),
                tradeEntity.product.id.eq(productId)
            )
            .orderBy(OrderSpecifier(Order.DESC, tradeEntity.updatedAt))
            .limit(5)
            .fetch()
    }

    private fun eqRequestType(
        requestType: RequestType
    ): OrderSpecifier<*> {
        return if (requestType == RequestType.ASK) OrderSpecifier(Order.ASC, tradeEntity.price)
        else OrderSpecifier(Order.DESC, tradeEntity.price)
    }

    private fun eqSize(
        size: String?
    ): BooleanExpression? {
        return if (size == null) null else tradeEntity.size.eq(size)
    }
}