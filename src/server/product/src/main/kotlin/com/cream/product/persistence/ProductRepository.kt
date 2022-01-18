package com.cream.product.persistence

import com.cream.product.dto.ProductWithWishDTO
import com.cream.product.model.ProductEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query


interface ProductRepository: JpaRepository<ProductEntity, Long> {
    @Query("SELECT p.id, " +
            "p.original_name AS originalName, " +
            "p.translated_name AS translatedName, " +
            "p.original_price AS originalPrice, " +
            "p.gender, " +
            "p.category, " +
            "p.color, " +
            "p.style_code AS styleCode, " +
            "p.wish_cnt AS wishCnt, " +
            "p.collection_id AS collectionId, " +
            "p.brand_id AS brandId, " +
            "p.brand_name AS brandName, " +
            "p.background_color AS backgroundColor, " +
            "p.image_urls AS imageUrls, " +
            "p.sizes, " +
            "p.released_date AS releasedDate, " +
            "p.highest_bid AS highestBid," +
            "p.total_sale AS totalSale, " +
            "group_concat(w.size) AS wishList " +
            "FROM product AS p " +
            "LEFT JOIN wish AS w " +
            "ON p.id=w.product_id AND w.user_id=:userId " +
            "GROUP BY p.id " +
            "ORDER BY :sort " +
            "LIMIT :offset, :limit" , nativeQuery = true)
    fun findAllWithWish(userId: Long, offset: Int, limit: Int, sort: String): MutableList<ProductWithWishDTO>
    @Query("SELECT p.id, " +
            "p.original_name AS originalName, " +
            "p.translated_name AS translatedName, " +
            "p.original_price AS originalPrice, " +
            "p.gender, " +
            "p.category, " +
            "p.color, " +
            "p.style_code AS styleCode, " +
            "p.wish_cnt AS wishCnt, " +
            "p.collection_id AS collectionId, " +
            "p.brand_id AS brandId, " +
            "p.brand_name AS brandName, " +
            "p.background_color AS backgroundColor, " +
            "p.image_urls AS imageUrls, " +
            "p.sizes, " +
            "p.released_date AS releasedDate, " +
            "p.highest_bid AS highestBid," +
            "p.total_sale AS totalSale, " +
            "group_concat(w.size) AS wishList " +
            "FROM product AS p " +
            "LEFT JOIN wish AS w " +
            "ON p.id=w.product_id AND w.user_id=:userId " +
            "AND p.id=:productId " +
            "GROUP BY p.id" , nativeQuery = true)
    fun findOneWithWish(userId: Long, productId: Long): ProductWithWishDTO
}