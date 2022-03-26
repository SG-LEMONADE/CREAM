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
import com.fasterxml.jackson.module.kotlin.readValue
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import kotlin.streams.toList

@Service
class HomeService {
    @Autowired
    private lateinit var bannerRepository: BannerRepository

    @Autowired
    private lateinit var sectionRepository: SectionRepository

    @Autowired
    private lateinit var productRepository: ProductRepository

    @Autowired
    private lateinit var logServiceClient: LogServiceClient

    fun getHomeView(
        userId: Long?
    ): HomeDTO {
        val homeBannerAds: List<HomeAdDTO> = getAds()

        val homeProductSections: List<SectionDTO> = getSections(userId)

        val recommendProducts: List<ProductDTO> = getRecommendedProducts(userId)

        return HomeDTO(homeBannerAds, homeProductSections, recommendProducts)
    }

    private fun getAds(
    ): List<HomeAdDTO> {
        return bannerRepository.findAllByValidIsTrue()
            .stream().map {
                HomeAdDTO(it.imageUrl, it.backgroundColor)
            }.toList()
    }

    private fun getSections(
        userId: Long?
    ): List<SectionDTO> {
        return sectionRepository.findAllByValidIsTrue()
            .stream().map { section ->
                val filter = parseFilterFromString(section.filterInfo)
                val products = getSectionProducts(userId, filter)

                SectionDTO(section, products)
            }.toList()
    }

    private fun parseFilterFromString(
        filterInfo: String
    ): FilterRequestDTO {
        return ObjectMapper().readValue(filterInfo, FilterRequestDTO::class.java)
    }

    private fun getSectionProducts(
        userId: Long?,
        filter: FilterRequestDTO
    ): List<ProductDTO> {
        if (userId == null) {
            return productRepository.getProducts(0, 16, "total_sale", filter).stream()
                .map { ProductDTO(it) }
                .toList()
        }
        return productRepository.getProductsWithWish(userId, 0, 16, "total_sale", filter).stream()
            .map { ProductDTO(it) }
            .toList()
    }

    private fun getRecommendedProducts(
        userId: Long?
    ): List<ProductDTO> {
        if (userId == null){
            return listOf()
        }
        val recommendedProductIds = getRecommendedProductIds(userId)
        return getSortedRecommendedProductsFromIds(userId, recommendedProductIds)
    }

    private fun getSortedRecommendedProductsFromIds(
        userId: Long,
        recommendedProductIds: List<Long>
    ): List<ProductDTO>{

        val unSortedRecommendedProducts = getRecommendedProductsFromIds(userId, recommendedProductIds)

        val sortedRecommendedProducts = ArrayList<ProductDTO>()
        recommendedProductIds.forEach {
            for (product in unSortedRecommendedProducts) {
                if (product.id == it){
                    sortedRecommendedProducts.add(product)
                    break
                }
            }
        }
        return sortedRecommendedProducts
    }

    private fun getRecommendedProductIds(
        userId: Long
    ): List<Long> {
        return logServiceClient.getRecommendedProducts(userId);
    }

    private fun getRecommendedProductsFromIds(
        userId: Long,
        recommendedProductIds: List<Long>
    ): List<ProductDTO>{
        val recommendFilter = FilterRequestDTO(recommendation = recommendedProductIds)

        return productRepository.getProductsWithWish(userId, 0, 30, null, recommendFilter)
            .stream()
            .map { ProductDTO(it) }
            .toList()
    }


}