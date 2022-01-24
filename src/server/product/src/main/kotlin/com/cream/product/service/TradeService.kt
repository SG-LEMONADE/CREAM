package com.cream.product.service

import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.dto.tradeDTO.TradeRegisterDTO
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.TradeRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class TradeService {
    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var tradeRepository: TradeRepository

    fun create(tradeRegisterDTO: TradeRegisterDTO, userId: Long, productId: Long, size: String) {
        val product = productRepository.getById(productId)
        tradeRepository.save(tradeRegisterDTO.toEntity(userId, product, size))
    }

    @Transactional
    fun delete(tradeId: Long) {
        tradeRepository.getById(tradeId).tradeStatus = TradeStatus.CANCELED
    }

    @Transactional
    fun buyOrSellProduct(productId: Long, size: String, requestType: RequestType, userId: Long) {
        val trade = tradeRepository.findFirstTrade(productId, size, requestType)
        val product = productRepository.findById(productId)
        trade.tradeStatus = TradeStatus.COMPLETED
        trade.counterpartUserId = userId
        product.orElseThrow().totalSale += 1
    }
}