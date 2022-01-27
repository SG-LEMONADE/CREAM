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
    fun create(productId: Long, price: Long): Price {
        val priceEntity = priceRepository.findOneByCreatedDateAndProductId(LocalDate.now(), productId)
        if (priceEntity != null){
            priceEntity.price = price
            return priceEntity
        }
        return priceRepository.save(Price(productId = productId, price = price))
    }

    fun getPriceListByDate(productId: Long): PricesByDateDTO {
        val totalList = priceRepository.findAllByProductId(productId)
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