package com.cream.product.model

import javax.persistence.*

@Entity
@Table(name = "section")
class Section (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @Column
    var header: String,

    @Column
    var detail: String,

    @Column
    var imageUrl: String,

    @Column
    var filterInfo: String,

    @Column
    var valid: Boolean
)