package com.cream.product.persistence

import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.model.QTrade
import com.cream.product.model.Trade
import com.querydsl.core.types.Order
import com.querydsl.core.types.OrderSpecifier
import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport
import java.time.LocalDateTime

interface TradeRepositoryCustom {
    fun findFirstTrade(productId: Long, size: String, requestType: RequestType): Trade
    fun findAllByPageAndStatus(userId: Long, offset: Long, limit: Long, requestType: RequestType, tradeStatus: TradeStatus): List<Trade>
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
        return from(tradeEntity)
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
        return from(tradeEntity)
            .where(
                tradeEntity.requestType.eq(requestType),
                tradeEntity.tradeStatus.eq(tradeStatus),
                tradeEntity.userId.eq(userId).or(tradeEntity.counterpartUserId.eq(userId))
            )
            .offset(offset)
            .limit(limit)
            .fetch()
    }



    private fun eqRequestType(requestType: RequestType): OrderSpecifier<*> {
        return if (requestType == RequestType.ASK) OrderSpecifier(Order.ASC, tradeEntity.price) else OrderSpecifier(Order.DESC, tradeEntity.price)
    }
}