package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name="tag")
class TagEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long = 0,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @JoinColumn(name="product_id") var product: ProductEntity,
    @Column(name="name") var name: String
    )