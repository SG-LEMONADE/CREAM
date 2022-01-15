package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name="wish")
class WishEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long = 0,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @Column(name="product_id") var product: ProductEntity,
    @Column(name="user_id") var userId: Long
    )