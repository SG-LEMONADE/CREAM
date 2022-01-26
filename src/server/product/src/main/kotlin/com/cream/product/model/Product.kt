package com.cream.product.model

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import javax.persistence.*

@Entity
@Table(name = "product")
class Product(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id") var id: Long? = null,
    @Column(name = "original_name") var originalName: String,
    @Column(name = "translated_name") var translatedName: String,
    @Column(name = "original_price") var originalPrice: Int,
    @Column(name = "gender") var gender: String,
    @Column(name = "category") var category: String,
    @Column(name = "color") var color: String?,
    @Column(name = "style_code") var styleCode: String,
    @Column(name = "wish_cnt") var wishCnt: Int,
    @JsonIgnore @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY) @JoinColumn(name = "collection_id") var collection: Collection?,
    @JsonIgnore @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY) @JoinColumn(name = "brand_id") var brand: Brand?,
    @Column(name = "brand_name") var brandName: String,
    @Column(name = "background_color") var backgroundColor: String,
    @Column(name = "image_urls") var imageUrls: String,
    @Column(name = "sizes") var sizes: String,
    @Column(name = "released_date") var releasedDate: LocalDate?,
    @Column(name = "total_sale") var totalSale: Int
)