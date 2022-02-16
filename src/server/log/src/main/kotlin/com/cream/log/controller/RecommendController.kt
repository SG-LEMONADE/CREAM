package com.cream.log.controller

import com.cream.log.service.RecommendService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/recommendations")
class RecommendController {

    @Autowired
    lateinit var recommendService: RecommendService

    @GetMapping("/{userId}")
    fun getRecommendedItems(
        @PathVariable userId: Long
    ): List<Long> {
        return recommendService.getProductsId(userId)
    }
}