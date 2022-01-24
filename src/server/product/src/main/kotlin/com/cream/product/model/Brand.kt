package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "brand")
class Brand(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id") var id: Long? = null,
    @Column(name = "name") var name: String,
    @Column(name = "logo_image_url") var logoImageUrl: String
)