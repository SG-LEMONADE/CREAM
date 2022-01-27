package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "collection")
class Collection(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    var brand: Brand,

    @Column
    var name: String,
)