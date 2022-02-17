package com.cream.user.model

import com.cream.user.constant.UserStatus
import com.cream.user.converter.UserStatusConverter
import java.time.LocalDateTime
import javax.persistence.*
import javax.validation.constraints.Email
import javax.validation.constraints.Max
import javax.validation.constraints.Min

@Entity
@Table(name = "user")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    var id: Long? = null,

    @field:Email
    @Column
    var email: String,

    @Column
    var password: String,

    @Column
    var name: String?,

    @Column
    var address: String?,

    @Column
    var gender: String?,

    @Column
    var age: Int?,

    @field:Min(220)
    @field:Max(300)
    @Column
    var shoeSize: Int,

    @Column
    var profileImageUrl: String?,

    @Convert(converter = UserStatusConverter::class)
    @Column
    var status: UserStatus,

    @Column
    var passwordChangedDatetime: LocalDateTime?,

    @Column
    var lastLoginDatetime: LocalDateTime?,

    @Column
    var createdAt: LocalDateTime = LocalDateTime.now(),

    @Column
    var updatedAt: LocalDateTime?
)