package com.cream.product.model

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import javax.persistence.*

@Entity
@Table(name = "product")
class Product(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @Column
    var originalName: String,

    @Column
    var translatedName: String,

    @Column
    var originalPrice: Int,

    @Column
    var gender: String,

    @Column
    var category: String,

    @Column
    var color: String?,

    @Column
    var styleCode: String,

    @Column
    var wishCnt: Int,

    @Column
    var brandName: String,

    @Column
    var backgroundColor: String,

    @Column
    var imageUrls: String,

    @Column
    var sizes: String,

    @Column
    var releasedDate: LocalDate?,

    @Column
    var totalSale: Int,

    @JsonIgnore
    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    var brand: Brand?,

    @JsonIgnore
    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY)
    @JoinColumn(name = "collection_id")
    var collection: Collection?
)