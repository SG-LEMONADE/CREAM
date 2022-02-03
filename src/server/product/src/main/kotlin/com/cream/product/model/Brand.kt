package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "brand")
class Brand(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @Column
    var name: String,

    @Column
    var logoImageUrl: String?
)