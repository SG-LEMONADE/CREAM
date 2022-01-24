package com.cream.product.controller

import com.cream.product.dto.filterDTO.FilterResponseDTO
import com.cream.product.service.FilterService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/filters")
class FilterController {

    @Autowired
    lateinit var filterService: FilterService

    @GetMapping()
    fun findFilters(): ResponseEntity<FilterResponseDTO> {
        return ResponseEntity.ok(filterService.findFilters())
    }
}