package com.cream.user.model

import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name = "user_entity")
class UserEntity(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "id") var id: Long? = null,
    @Column(name = "email") var email: String,
    @Column(name = "password") var password: String,
    @Column(name = "name") var name: String?,
    @Column(name = "address") var address: String?,
    @Column(name = "gender") var gender: Boolean?,
    @Column(name = "age") var age: Int?,
    @Column(name = "shoe_size") var shoeSize: Int,
    @Column(name = "profile_image_url") var profileImageUrl: String?,
    @Column(name = "status") var status: Int,
    @Column(name = "password_changed_datetime") var passwordChangedDateTime: LocalDateTime?,
    @Column(name = "last_login_datetime") var lastLoginDateTime: LocalDateTime?,
    @Column(name = "create_at") var createAt: LocalDateTime = LocalDateTime.now(),
    @Column(name = "update_at") var updateAt: LocalDateTime?
)