package com.cream.gateway.filter

import io.jsonwebtoken.*
import lombok.extern.slf4j.Slf4j
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.cloud.gateway.filter.GatewayFilter
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory
import org.springframework.http.server.reactive.ServerHttpRequest
import org.springframework.http.server.reactive.ServerHttpResponse
import org.springframework.stereotype.Component
import reactor.core.publisher.Mono
import javax.crypto.SecretKey

@Component
@Slf4j
class JwtAuthFilter: AbstractGatewayFilterFactory<JwtAuthFilter.Config> {

    @Value("\${auth-excluded-path}")
    lateinit var authExcludedPaths: List<String>

    @Value("\${secret-key}")
    lateinit var secretKey: String

    class Config {}

    constructor(): super(Config::class.java)

    override fun apply(config: Config): GatewayFilter {
        return GatewayFilter { exchange, chain ->
            var request: ServerHttpRequest = exchange.request
            var response: ServerHttpResponse = exchange.response
            val path = request.path.toString()
            val token: String = request.headers["Authorization"]?.get(0)?.substring(7) ?: ""
            if (path !in authExcludedPaths){
                Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).body.subject.toInt()
            }

            return@GatewayFilter chain.filter(exchange).then(Mono.fromRunnable {
                if (path !in authExcludedPaths && token != "" && path != "/users/logout"){
                    exchange.response.headers.add("Authorization", request.headers["Authorization"]?.get(0)?: "")
                }
            })
        }
    }
}