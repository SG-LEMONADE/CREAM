package com.cream.product.service

import com.cream.product.dto.FilterResponseDTO
import com.cream.product.persistence.BrandRepository
import com.cream.product.persistence.CollectionRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class FilterService {

    @Autowired
    lateinit var brandRepository: BrandRepository

    @Autowired
    lateinit var collectionRepository: CollectionRepository

    @Value("\${gender}")
    lateinit var genders: Array<String>

    @Value("\${category}")
    lateinit var categories: Array<String>

    fun findFilters(): FilterResponseDTO {
        return FilterResponseDTO(
            brandRepository.findAll(),
            collectionRepository.findAll(),
            genders.toList(),
            categories.toList()
        )
    }
}