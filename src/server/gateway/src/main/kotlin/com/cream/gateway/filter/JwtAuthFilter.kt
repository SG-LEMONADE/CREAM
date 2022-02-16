package com.cream.gateway.filter

import com.cream.gateway.error.LogoutTokenException
import com.cream.gateway.error.TokenInvalidException
import io.jsonwebtoken.Jwts
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Value
import org.springframework.cloud.gateway.filter.GatewayFilter
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.http.server.reactive.ServerHttpRequest
import org.springframework.http.server.reactive.ServerHttpResponse
import org.springframework.stereotype.Component
import reactor.core.publisher.Mono

@Component
class JwtAuthFilter() : AbstractGatewayFilterFactory<JwtAuthFilter.Config>(Config::class.java) {

    @Value("\${auth-included-path}")
    lateinit var authIncludedPaths: List<String>

    @Value("\${secret-key}")
    lateinit var secretKey: String

    @Autowired
    lateinit var redisTemplate: StringRedisTemplate

    class Config {}

    override fun apply(config: Config): GatewayFilter {
        return GatewayFilter { exchange, chain ->
            val request: ServerHttpRequest = exchange.request

            // 현재 요청된 주소 확인
            val path = request.path.toString()

            // 토큰 확인
            val token: String = request.headers["Authorization"]?.get(0)?.substring(7) ?: ""
            if (token != ""){
                val userId = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).body.subject.toLong()
                // 로그아웃한 유저인지 확인
                val stringValueOperation = redisTemplate.opsForValue()
                if (stringValueOperation.get(token) != null){
                    throw LogoutTokenException()
                }
                // custom header 인  userId 추가
                request.mutate().header("userId", userId.toString()).build()
            }

            // 토큰 값이 필수이고 비어있다면 에러
            if (path in authIncludedPaths && token == "") throw TokenInvalidException()
            return@GatewayFilter chain.filter(exchange).then(Mono.fromRunnable {
                // 인증을 거쳐야 하는 api 가 아니라면 response 에 요청 받았던 토큰을 넣어주기
                if (token != "" && path != "/users/logout"){
                    exchange.response.headers.add("Authorization", request.headers["Authorization"]?.get(0)?: "")
                }
            })
        }
    }
}