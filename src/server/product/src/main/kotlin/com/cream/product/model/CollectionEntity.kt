package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "collection")
class CollectionEntity(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id") var id: Long? = null,
    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY) @JoinColumn(name = "brand_id") var brand: BrandEntity,
    @Column(name = "name") var name: String,
)