package com.cream.product.converter

import com.cream.product.constant.TradeStatus
import javax.persistence.AttributeConverter
import javax.persistence.Converter

@Converter
class TradeStatusConverter : AttributeConverter<TradeStatus, Int> {
    override fun convertToDatabaseColumn(attribute: TradeStatus?): Int {
        return attribute?.value ?: 0
    }

    override fun convertToEntityAttribute(dbData: Int?): TradeStatus {
        return when (dbData) {
            0 -> TradeStatus.WAITING
            1 -> TradeStatus.IN_PROGRESS
            2 -> TradeStatus.COMPLETED
            3 -> TradeStatus.CANCELED
            else -> throw EnumConstantNotPresentException(TradeStatus::class.java, dbData.toString())
        }
    }
}