package com.cream.auction

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class AuctionApplication

fun main(args: Array<String>) {
    runApplication<AuctionApplication>(*args)
}
