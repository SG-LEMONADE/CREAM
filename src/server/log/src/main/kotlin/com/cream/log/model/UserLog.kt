package com.cream.log.model

import nonapi.io.github.classgraph.json.Id
import org.springframework.data.mongodb.core.mapping.Field
import java.time.LocalDateTime

open class UserLog(
    @Id
    var id: String? = null,

    @Field
    var userId: Long = 0,

    @Field
    var productId: Long = 0,

    @Field
    var action: Int = 0,

    @Field
    var createdAt: LocalDateTime = LocalDateTime.now()
)