package com.cream.log

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cloud.netflix.eureka.EnableEurekaClient

@SpringBootApplication
@EnableEurekaClient
class LogApplication

fun main(args: Array<String>) {
    runApplication<LogApplication>(*args)
}
