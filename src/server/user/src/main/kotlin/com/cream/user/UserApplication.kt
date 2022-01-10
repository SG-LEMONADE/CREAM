package com.cream.user

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cache.annotation.EnableCaching

@SpringBootApplication
@EnableCaching
class UserApplication

fun main(args: Array<String>) {
    runApplication<UserApplication>(*args)
}
