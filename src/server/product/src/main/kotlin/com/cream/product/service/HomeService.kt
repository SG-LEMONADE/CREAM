package com.cream.product.service

import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.homeDTO.HomeDTO
import com.cream.product.dto.homeDTO.SectionDTO
import com.cream.product.dto.productDTO.ProductDTO
import com.cream.product.persistence.BannerRepository
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.SectionRepository
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import kotlin.streams.toList

@Service
class HomeService {
    @Autowired
    lateinit var bannerRepository: BannerRepository

    @Autowired
    lateinit var sectionRepository: SectionRepository

    @Autowired
    lateinit var productRepository: ProductRepository

    fun getHomeView(
        userId: Long?
    ): HomeDTO {
        val imageUrls: List<String> = bannerRepository.findAllByValidIsTrue()
            .stream().map {
                it.imageUrl
            }.toList()

        val sections: List<SectionDTO> = sectionRepository.findAllByValidIsTrue()
            .stream().map { section ->
                val filter = ObjectMapper().readValue(section.filterInfo, FilterRequestDTO::class.java)
                val products = if (userId == null) {
                    productRepository.getProducts(0, 16, "total_sale", filter).stream()
                        .map {
                            ProductDTO(it)
                        }.toList()
                } else {
                    productRepository.getProducts(0, 16, "total_sale", filter).stream()
                        .map {
                            ProductDTO(it)
                        }.toList()
                }

                SectionDTO(section.header, section.detail, section.imageUrl, products)
            }.toList()

        return HomeDTO(imageUrls, sections)
    }
}