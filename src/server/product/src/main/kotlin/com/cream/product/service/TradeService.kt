package com.cream.product.service

import com.cream.product.client.LogServiceClient
import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.tradeDTO.TradeRegisterDTO
import com.cream.product.model.Trade
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.TradeRepository
import feign.FeignException
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.time.LocalDateTime
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
        val product = productRepository.getById(productId)
        tradeRepository.save(tradeRegisterDTO.toEntity(userId, product, size))
    }

    fun getTradeList(
        userId: Long,
        pageDTO: PageDTO,
        requestType: RequestType,
        tradeStatus: TradeStatus
    ): List<Trade> {
        return tradeRepository.findAllByPageAndStatus(userId, pageDTO.offset(), pageDTO.limit(), requestType, tradeStatus)
    }

    @Transactional
    fun delete(
        tradeId: Long
    ) {
        val trade = tradeRepository.getById(tradeId)

        trade.tradeStatus = TradeStatus.CANCELED
        trade.updatedAt = LocalDateTime.now()
    }

    @Transactional
    fun buyOrSellProduct(
        productId: Long,
        size: String,
        requestType: RequestType,
        userId: Long
    ) {
        val trade = tradeRepository.findFirstTrade(productId, size, requestType)
        val product = productRepository.findById(productId)

        try {
            logServiceClient.insertPrice(productId, trade.price)
        } catch (ex: FeignException) {
            log.error(ex.message)
        }

        trade.tradeStatus = TradeStatus.COMPLETED
        trade.counterpartUserId = userId
        trade.updatedAt = LocalDateTime.now()
        product.orElseThrow().totalSale += 1
    }
}