package com.cream.product.persistence

import com.cream.product.constant.RequestTradeStatus
import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.tradeDTO.*
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
    fun findAllByPageAndStatus(userId: Long, offset: Long, limit: Long, requestType: RequestType, tradeStatus: RequestTradeStatus): List<TradeHistoryDTO>

    fun findByProductIdWithCount(size: String?, productId: Long, requestType: RequestType): List<TradeBySizeCountDTO>
    fun findByProductIdCompleted(productId: Long, size: String?): List<TradeLastCompletedDTO>

    fun findCountsByTradeStatus(userId: Long, requestType: RequestType): List<TradeStatusCounterDTO>
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
            .orderBy(
                getOrderByRequestType(requestType),
                OrderSpecifier(Order.ASC, tradeEntity.updatedAt)
            )
            .fetchFirst()
    }

    override fun findAllByPageAndStatus(
        userId: Long,
        offset: Long,
        limit: Long,
        requestType: RequestType,
        tradeStatus: RequestTradeStatus
    ): List<TradeHistoryDTO> {
        return jpaQueryFactory
            .select(
                QTradeHistoryDTO(
                    tradeEntity.product.originalName,
                    tradeEntity.size,
                    tradeEntity.product.imageUrls,
                    tradeEntity.product.backgroundColor,
                    tradeEntity.tradeStatus,
                    tradeEntity.updatedAt,
                    tradeEntity.validationDateTime
                )
            )
            .from(tradeEntity)
            .where(
                tradeEntity.requestType.eq(requestType),
                tradeEntity.userId.eq(userId).or(tradeEntity.counterpartUserId.eq(userId)),
                eqTradeStatus(tradeStatus)
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
        productId: Long,
        size: String?
    ): List<TradeLastCompletedDTO> {
        return jpaQueryFactory
            .select(
                QTradeLastCompletedDTO(
                    tradeEntity.size,
                    tradeEntity.price,
                    tradeEntity.updatedAt
                )
            )
            .from(tradeEntity)
            .where(
                tradeEntity.tradeStatus.eq(TradeStatus.COMPLETED),
                tradeEntity.product.id.eq(productId),
                eqSize(size)
            )
            .orderBy(OrderSpecifier(Order.DESC, tradeEntity.updatedAt))
            .limit(5)
            .fetch()
    }

    override fun findCountsByTradeStatus(
        userId: Long,
        requestType: RequestType
    ): List<TradeStatusCounterDTO> {
        return jpaQueryFactory
            .select(
                QTradeStatusCounterDTO(
                    tradeEntity.tradeStatus,
                    tradeEntity.count()
                )
            )
            .from(tradeEntity)
            .where(
                tradeEntity.userId.eq(userId),
                tradeEntity.requestType.eq(requestType)
            )
            .groupBy(tradeEntity.tradeStatus)
            .orderBy(OrderSpecifier(Order.ASC, tradeEntity.tradeStatus))
            .fetch()
    }

    private fun getOrderByRequestType(
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

    private fun eqTradeStatus(
        status: RequestTradeStatus
    ): BooleanExpression? {
        return when (status) {
            (RequestTradeStatus.ALL) -> null
            (RequestTradeStatus.WAITING) -> tradeEntity.tradeStatus.eq(TradeStatus.WAITING)
            (RequestTradeStatus.IN_PROGRESS) -> tradeEntity.tradeStatus.eq(TradeStatus.IN_PROGRESS)
            (RequestTradeStatus.FINISHED) -> tradeEntity.tradeStatus.eq(TradeStatus.CANCELED)
                .or(tradeEntity.tradeStatus.eq(TradeStatus.EXPIRED))
                .or(tradeEntity.tradeStatus.eq(TradeStatus.COMPLETED))
            else -> null
        }
    }
}