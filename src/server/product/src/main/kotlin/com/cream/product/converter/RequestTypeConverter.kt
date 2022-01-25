package com.cream.product.converter

import com.cream.product.constant.RequestType
import javax.persistence.AttributeConverter
import javax.persistence.Converter

@Converter
class RequestTypeConverter : AttributeConverter<RequestType, Int> {
    override fun convertToDatabaseColumn(attribute: RequestType?): Int {
        return attribute?.value ?: 0
    }

    override fun convertToEntityAttribute(dbData: Int?): RequestType? {
        return when (dbData) {
            0 -> RequestType.ASK
            1 -> RequestType.BID
            null -> null
            else -> throw EnumConstantNotPresentException(RequestType::class.java, dbData.toString())
        }
    }
}