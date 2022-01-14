package com.cream.product

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class ProductApplication

fun main(args: Array<String>) {
    runApplication<ProductApplication>(*args)
}
