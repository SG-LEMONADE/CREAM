package com.cream.log

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class LogApplication

fun main(args: Array<String>) {
    runApplication<LogApplication>(*args)
}
