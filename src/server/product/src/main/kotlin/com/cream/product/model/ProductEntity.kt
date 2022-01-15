package com.cream.product.model

import java.time.LocalDate
import javax.persistence.*

@Entity
@Table(name="product")
class ProductEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long = 0,
    @Column(name="original_name") var name: String,
    @Column(name="translated_name") var translatedName: String,
    @Column(name="original_price") var originalPrice: Int,
    @Column(name="gender") var gender: Boolean,
    @Column(name="category") var category: String,
    @Column(name="style_code") var styleCode: String,
    @Column(name="wish_cnt") var wishCnt: Int,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @Column(name="collection_id") var collection: CollectionEntity,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @Column(name="brand_id") var brand: BrandEntity,
    @Column(name="brand_name") var brandName: String,
    @Column(name="background_color") var backgroundColor: String,
    @Column(name="image_urls") var imageUrls: String,
    @Column(name="released_date") var releaseDate: LocalDate
        )
