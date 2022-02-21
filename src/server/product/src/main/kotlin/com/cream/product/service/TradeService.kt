package com.cream.product.service

import com.cream.product.client.LogServiceClient
import com.cream.product.constant.RequestTradeStatus
import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.UserLogDTO
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.tradeDTO.MyPageTradeListDTO
import com.cream.product.dto.tradeDTO.TradeHistoryCounterDTO
import com.cream.product.dto.tradeDTO.TradeRegisterDTO
import com.cream.product.error.BaseException
import com.cream.product.error.ErrorCode
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.TradeRepository
import com.fasterxml.jackson.databind.ObjectMapper
import feign.FeignException
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.Lock
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import javax.persistence.LockModeType
import javax.transaction.Transactional

@Service
class TradeService {
    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var tradeRepository: TradeRepository

    @Autowired
    lateinit var logServiceClient: LogServiceClient

    private val log = LoggerFactory.getLogger(javaClass)

    fun create(
        tradeRegisterDTO: TradeRegisterDTO,
        userId: Long,
        productId: Long,
        size: String
    ) {
        val product = productRepository.findById(productId).orElseThrow()
        if (!ObjectMapper().readValue(product.sizes, ArrayList::class.java).contains(size)) {
            throw BaseException(ErrorCode.INVALID_SIZE_FOR_PRODUCT)
        }

        if (tradeRegisterDTO.requestType == RequestType.BID) {
            try {
                logServiceClient.insertUserLogData(UserLogDTO(userId, productId, 3))
            } catch (ex: FeignException) {
                log.error(ex.message)
            }
        }

        tradeRepository.save(tradeRegisterDTO.toEntity(userId, product, size))
    }

    fun getTradeList(
        userId: Long,
        pageDTO: PageDTO,
        requestType: RequestType,
        tradeStatus: RequestTradeStatus
    ): MyPageTradeListDTO {
        val reversedRequestType = if (requestType == RequestType.BID) RequestType.ASK else RequestType.BID
        val trades = tradeRepository.findAllByPageAndStatus(
            userId, pageDTO.offset(), pageDTO.perPage,
            requestType, reversedRequestType, tradeStatus
        )

        val counters = tradeRepository.findCountsByTradeStatus(userId, requestType, reversedRequestType)

        var totalCnt = 0
        var waitingCnt = 0
        var inProgress = 0
        var finishedCnt = 0

        counters.forEach {
            val cnt = it.counter.toInt()
            totalCnt += cnt
            when (it.tradeStatus) {
                (TradeStatus.COMPLETED) -> finishedCnt += cnt
                (TradeStatus.IN_PROGRESS) -> inProgress += cnt
                (TradeStatus.WAITING) -> waitingCnt += cnt
                else -> {}
            }
        }

        return MyPageTradeListDTO(
            TradeHistoryCounterDTO(
                totalCnt,
                waitingCnt,
                inProgress,
                finishedCnt
            ),
            trades
        )
    }

    @Transactional
    @Lock(value = LockModeType.PESSIMISTIC_WRITE)
    fun delete(
        tradeId: Long,
        userId: Long
    ) {
        val trade = tradeRepository.findById(tradeId).orElseThrow()

        if (trade.userId != userId) throw BaseException(ErrorCode.USER_DOES_NOT_MATCH_TRADE_UPDATE)

        trade.tradeStatus = TradeStatus.CANCELED
        trade.updatedAt = LocalDateTime.now()
    }

    @Transactional
    @Lock(value = LockModeType.PESSIMISTIC_WRITE)
    fun buyOrSellProduct(
        productId: Long,
        size: String,
        requestType: RequestType,
        userId: Long
    ) {
        val trade = tradeRepository.findFirstTrade(productId, size, requestType)
        val product = productRepository.findById(productId).orElseThrow()

        if (trade.userId == userId) throw BaseException(ErrorCode.CANNOT_TRADE_MYSELF)

        try {
            logServiceClient.insertPrice(productId, size, trade.price)
        } catch (ex: FeignException) {
            log.error(ex.message)
        }

        if (requestType == RequestType.ASK) {
            try {
                logServiceClient.insertUserLogData(UserLogDTO(userId, productId, 3))
            } catch (ex: FeignException) {
                log.error(ex.message)
            }
        }

        trade.tradeStatus = TradeStatus.COMPLETED
        trade.counterpartUserId = userId
        trade.updatedAt = LocalDateTime.now()

        product.totalSale += 1
    }
}