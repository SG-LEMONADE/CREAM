package com.cream.log.controller

import com.cream.log.service.RecommendService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/recommendations")
class RecommendController {

    @Autowired
    lateinit var recommendService: RecommendService

    @GetMapping
    fun getRecommendedItems(
        @RequestHeader("userId", required = true) userId: Long
    ): List<Long>{
        return recommendService.getProductsId(userId)
    }
}