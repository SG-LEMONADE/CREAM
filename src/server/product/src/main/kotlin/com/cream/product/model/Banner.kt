package com.cream.product.model

import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name="banner")
class Banner (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    var id: Long? = null,

    @Column
    var imageUrl: String,

    @Column
    var valid: Boolean
)