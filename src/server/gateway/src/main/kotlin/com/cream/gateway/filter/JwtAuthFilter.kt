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

            // 현재 요청된 주소 확인
            val path = request.path.toString()
            // 토큰 확인
            val token: String = request.headers["Authorization"]?.get(0)?.substring(7) ?: ""

            // 만약 인증을 거쳐야 하는 api 라면
            if (path !in authExcludedPaths){
                // 인증 확인
                val userId = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).body.subject.toLong()
                // custom header 인  userId 추가
                request.mutate().header("userId", userId.toString()).build()
            }

            return@GatewayFilter chain.filter(exchange).then(Mono.fromRunnable {
                // 인증을 거쳐야 하는 api 가 아니라면 response 에 요청 받았던 토큰을 넣어주기
                if (path !in authExcludedPaths && token != "" && path != "/users/logout"){
                    exchange.response.headers.add("Authorization", request.headers["Authorization"]?.get(0)?: "")
                }
            })
        }
    }
}