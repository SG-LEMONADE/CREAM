package com.cream.gateway.filter

import io.jsonwebtoken.Jwts
import org.springframework.beans.factory.annotation.Value
import org.springframework.cloud.gateway.filter.GatewayFilter
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory
import org.springframework.http.server.reactive.ServerHttpRequest
import org.springframework.http.server.reactive.ServerHttpResponse
import org.springframework.stereotype.Component
import reactor.core.publisher.Mono

@Component
class JwtAuthFilter() : AbstractGatewayFilterFactory<JwtAuthFilter.Config>(Config::class.java) {

    @Value("\${auth-excluded-path}")
    lateinit var authExcludedPaths: List<String>

    @Value("\${secret-key}")
    lateinit var secretKey: String

    class Config {}

    override fun apply(config: Config): GatewayFilter {
        return GatewayFilter { exchange, chain ->
            val request: ServerHttpRequest = exchange.request
            var response: ServerHttpResponse = exchange.response
            val path = request.path.toString()
            val token: String = request.headers["Authorization"]?.get(0)?.substring(7) ?: ""
            if (path !in authExcludedPaths){
                val userId = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).body.subject.toLong()
                request.mutate().header("userId", userId.toString()).build()
            }

            return@GatewayFilter chain.filter(exchange).then(Mono.fromRunnable {
                if (path !in authExcludedPaths && token != "" && path != "/users/logout"){
                    exchange.response.headers.add("Authorization", request.headers["Authorization"]?.get(0)?: "")
                }
            })
        }
    }
}