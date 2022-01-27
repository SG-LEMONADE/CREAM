package com.cream.product.client

import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody

@FeignClient(name="log")
interface LogServiceClient {

    @PostMapping("/prices/products/{productId}")
    fun insertPrice(@PathVariable productId: Long, @RequestBody price: Int)
}