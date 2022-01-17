package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name="brand")
class BrandEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long? = null,
    @Column(name="name") var name: String,
    @Column(name="info") var info: String
        )