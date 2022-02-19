package com.cream.product.service

import com.cream.product.client.LogServiceClient
import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.homeDTO.HomeAdDTO
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

    @Autowired
    lateinit var logServiceClient: LogServiceClient

    fun getHomeView(
        userId: Long?
    ): HomeDTO {
        val imageUrls: List<HomeAdDTO> = bannerRepository.findAllByValidIsTrue()
            .stream().map {
                HomeAdDTO(it.imageUrl, it.backgroundColor)
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
                    productRepository.getProductsWithWish(userId, 0, 16, "total_sale", filter).stream()
                        .map {
                            ProductDTO(it)
                        }.toList()
                }

                SectionDTO(section.header, section.detail, section.imageUrl, section.backgroundColor, products)
            }.toList()

        var recommendItems: List<ProductDTO> = listOf()

        if (userId != null) {
            val sortedRecommendedItems = ArrayList<ProductDTO>()
            val productIds = logServiceClient.getRecommendedItems(userId)

            // 만약 추천이 되어있다면 결과를 반환, 아니라면 null 을 반환
            if (productIds.isNotEmpty()) {
                val unSortedRecommendItems = productRepository.getProductsWithWish(
                    userId, 0, 30,
                    null, FilterRequestDTO(recommendation = productIds)
                )
                    .stream()
                    .map {
                        ProductDTO(it)
                    }.toList()

                productIds.forEach {
                    for (product in unSortedRecommendItems) {
                        if (product.id == it) {
                            sortedRecommendedItems.add(product)
                            break
                        }
                    }
                }
                recommendItems = sortedRecommendedItems.toList()
            }
        }

        return HomeDTO(imageUrls, sections, recommendItems)
    }
}