package com.cream.product.model

import java.util.*
import javax.persistence.*

@Entity
@Table(name="collection")
class CollectionEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long? = null,
    @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @JoinColumn(name="brand_id") var brand: BrandEntity,
    @Column(name="name") var name: String,
    @Column(name="info") var info: String,
    //@OneToMany(cascade = [CascadeType.ALL], mappedBy = "collection") var products: MutableSet<ProductEntity> = TreeSet()
        )