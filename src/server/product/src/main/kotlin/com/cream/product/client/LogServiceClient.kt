package com.cream.product.client

import com.cream.product.dto.UserLogDTO
import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.*

@FeignClient(name = "log")
interface LogServiceClient {

    @PostMapping("/prices/products/{productId}")
    fun insertPrice(@PathVariable productId: Long, @RequestBody price: Int)

    @PostMapping("/log")
    fun insertUserLogData(@RequestBody userLogDTO: UserLogDTO)

    @GetMapping("/recommendations")
    fun getRecommendedItems(@RequestHeader("userId") userId: Long): List<Long>
}