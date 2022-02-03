package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "collection")
class Collection(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @Column
    var name: String,

    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    var brand: Brand
)