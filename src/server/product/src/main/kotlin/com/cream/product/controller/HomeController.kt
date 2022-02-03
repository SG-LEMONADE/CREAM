package com.cream.product.controller

import com.cream.product.dto.homeDTO.HomeDTO
import com.cream.product.service.HomeService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping
class HomeController {
    @Autowired
    lateinit var homeService: HomeService

    @GetMapping
    fun getHomeView(
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<HomeDTO> {
        return ResponseEntity.ok(homeService.getHomeView(userId))
    }
}