package com.cream.log.model

import nonapi.io.github.classgraph.json.Id
import org.springframework.data.mongodb.core.mapping.Field
import java.time.LocalDate

open class Price(
    @Id
    var id: String? = null,

    @Field
    var productId: Long = 0,

    @Field
    var price: Long = 0,

    @Field
    var createdDate: LocalDate = LocalDate.now()
)