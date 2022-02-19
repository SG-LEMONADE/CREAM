package com.cream.product.client

import com.cream.product.dto.UserLogDTO
import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.*

@FeignClient(name = "log")
interface LogServiceClient {

    @PostMapping("/prices/products/{productId}/{size}")
    fun insertPrice(@PathVariable productId: Long, @PathVariable size: String, @RequestBody price: Int)

    @PostMapping("/log")
    fun insertUserLogData(@RequestBody userLogDTO: UserLogDTO)

    @GetMapping("/recommendations/{userId}")
    fun getRecommendedItems(@PathVariable userId: Long): List<Long>
}