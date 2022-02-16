package com.cream.log.model

import nonapi.io.github.classgraph.json.Id
import org.springframework.data.mongodb.core.mapping.Field

open class RecommendItem(
    @Id
    var id: String? = null,

    @Field
    var userId: Long = 0,

    @Field
    var recommendedItems: List<Long>
)