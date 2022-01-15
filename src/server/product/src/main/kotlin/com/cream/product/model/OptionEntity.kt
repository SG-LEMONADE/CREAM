package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name="option")
class OptionEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long = 0,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @Column(name="product_id") var product: ProductEntity,
    @Column(name="size") var size: Int,
    @Column(name="size_us") var sizeUs: Int?
        )