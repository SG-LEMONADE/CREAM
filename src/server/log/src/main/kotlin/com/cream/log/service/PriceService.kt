package com.cream.log.service

import com.cream.log.dto.PriceDTO
import com.cream.log.dto.PricesByDateDTO
import com.cream.log.model.Price
import com.cream.log.persistence.PriceRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDate

@Service
class PriceService {
    @Autowired
    lateinit var priceRepository: PriceRepository

    @Transactional
    fun create(
        productId: Long,
        size: String,
        price: Long
    ): Price {
        // 당일 가격이 이미 기록이 되어 있는지 확인해야합니다.
        val priceEntity = priceRepository.findOneByCreatedDateAndProductIdAndSize(LocalDate.now(), productId, size)
        val totalPriceEntity = priceRepository.findOneByCreatedDateAndProductIdAndSize(LocalDate.now(), productId, null)
        if (totalPriceEntity != null) {
            totalPriceEntity.price = price
        } else {
            priceRepository.save(Price(productId = productId, price = price, size = null))
        }
        if (priceEntity != null) {
            priceEntity.price = price
            return priceEntity
        }
        return priceRepository.save(Price(productId = productId, price = price, size = size))
    }

    fun getPriceListByDate(
        productId: Long,
        size: String?
    ): PricesByDateDTO {
        val totalList = priceRepository.findAllByProductIdAndSize(productId, size)
        val data = PricesByDateDTO()
        val today = LocalDate.now()
        totalList.forEach {
            if (it.createdDate.isAfter(today.minusMonths(1))) {
                data.oneMonth.add(PriceDTO(it))
            }
            if (it.createdDate.isAfter(today.minusMonths(3))) {
                data.threeMonth.add(PriceDTO(it))
            }
            if (it.createdDate.isAfter(today.minusMonths(6))) {
                data.sixMonth.add(PriceDTO(it))
            }
            if (it.createdDate.isAfter(today.minusYears(1))) {
                data.oneYear.add(PriceDTO(it))
            }
            data.total.add(PriceDTO(it))
        }
        return data
    }
}