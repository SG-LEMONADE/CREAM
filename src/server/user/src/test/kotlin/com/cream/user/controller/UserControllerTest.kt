package com.cream.user.controller

import com.cream.user.dto.RegisterUserDTO
import org.assertj.core.api.Assertions.assertThat
import org.h2.api.ErrorCode
import org.junit.jupiter.api.Test

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.boot.test.web.client.postForObject

@SpringBootTest(
    webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
    properties = ["spring.config.location=classpath:application-test.yml"]
)
internal class UserControllerTest(@Autowired val client: TestRestTemplate) {

    @Test
    fun `회원 가입 (join) 테스트`() {
        val user = RegisterUserDTO("test@test.com", "Testdd123!!", 300)

        val data = client.postForObject<ErrorCode>("/users/join", user)
        println(data)
        assertThat(data).isNotNull
    }

    @Test
    fun login() {
    }

    @Test
    fun refresh() {
    }

    @Test
    fun validate() {
    }

    @Test
    fun `me 테스트`() {
    }

    @Test
    fun verify() {
    }

    @Test
    fun logout() {
    }

    @Test
    fun update() {
    }
}