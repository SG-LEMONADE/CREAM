package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name="collection")
class CollectionEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long = 0,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @Column(name="brand_id") var brand: BrandEntity,
    @Column(name="name") var name: String,
    @Column(name="info") var info: String
        )