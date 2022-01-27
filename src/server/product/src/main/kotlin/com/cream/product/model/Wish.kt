package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "wish")
class Wish(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    var product: Product,

    @Column
    var userId: Long,

    @Column
    var size: String
)