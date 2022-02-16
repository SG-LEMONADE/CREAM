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
        requestType: RequestType // 구매 요청시에 가장 낮은 판매가격을, 판매 요청시에 가장 높은 구매 가격을 반환합니다.
    ): Trade {
        // 구매, 판매 별 가장 높은, 가장 낮은 가격의 거래를 불러옵니다.
        return jpaQueryFactory
            .select(tradeEntity)
            .from(tradeEntity)
            .where(
                tradeEntity.product.id.eq(productId),
                tradeEntity.size.eq(size),
                tradeEntity.tradeStatus.eq(TradeStatus.WAITING),
                // 유효기간이 지난 거래는 제외합니다.
                tradeEntity.validationDateTime.gt(LocalDateTime.now()),
                tradeEntity.requestType.eq(requestType)
            )
            .orderBy(
                // 가격 별로 정렬을 합니다. (마찬가지로 구매시 가장 낮은 판매가격순, 판매 시 가장 높은 구매 가격순)
                getOrderByRequestType(requestType),
                // 가격이 같을 시에 먼저 등록한 거래를 우선합니다.
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
        // 거래 내역을 반환합니다.
        return jpaQueryFactory
            .select(
                QTradeHistoryDTO(
                    tradeEntity.id,
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
        // 상품 상세 페이지 화면을 위한 거래 내역과 사이즈별 거래 개수를 반환합니다.
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
        // 상품 상세 페이지 화면을 위한 완료된 거래 5개를 가져옵니다.
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
        // 내 거래 내역 타입별 개수를 위한 count 함수입니다.
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

    // 아래는 공통적으로 사용되는 필터입니다.

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
        // 거래 상태별로 거래 내역을 분류해주는 필터입니다.
        return when (status) {
            (RequestTradeStatus.ALL) -> null
            // 대기중 내역
            (RequestTradeStatus.WAITING) -> tradeEntity.tradeStatus.eq(TradeStatus.WAITING)
            // 진행중 내역
            (RequestTradeStatus.IN_PROGRESS) -> tradeEntity.tradeStatus.eq(TradeStatus.IN_PROGRESS)
            // 종료된 내역
            (RequestTradeStatus.FINISHED) -> tradeEntity.tradeStatus.eq(TradeStatus.CANCELED)
                .or(tradeEntity.tradeStatus.eq(TradeStatus.EXPIRED))
                .or(tradeEntity.tradeStatus.eq(TradeStatus.COMPLETED))
            else -> null
        }
    }
}