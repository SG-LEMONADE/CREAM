package com.cream.user.model

import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name = "user")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    var id: Long? = null,

    @Column
    var email: String,

    @Column
    var password: String,

    @Column
    var name: String?,

    @Column
    var address: String?,

    @Column
    var gender: Boolean?,

    @Column
    var age: Int?,

    @Column
    var shoeSize: Int,

    @Column
    var profileImageUrl: String?,

    @Column
    var status: Int,

    @Column
    var passwordChangedDatetime: LocalDateTime?,

    @Column
    var lastLoginDatetime: LocalDateTime?,

    @Column
    var createdAt: LocalDateTime = LocalDateTime.now(),

    @Column
    var updatedAt: LocalDateTime?
)