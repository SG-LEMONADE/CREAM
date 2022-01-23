package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "wish")
class Wish(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id") var id: Long = 0,
    @ManyToOne(cascade = [CascadeType.DETACH], fetch = FetchType.LAZY) @JoinColumn(name = "product_id") var product: Product,
    @Column(name = "user_id") var userId: Long,
    @Column(name = "size") var size: String
)