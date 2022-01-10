package com.cream.gateway.filter

import com.cream.gateway.dto.ResponseDTO
import com.fasterxml.jackson.databind.ObjectMapper
import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import lombok.extern.slf4j.Slf4j
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.cloud.gateway.filter.GatewayFilter
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory
import org.springframework.http.HttpStatus
import org.springframework.http.server.reactive.ServerHttpRequest
import org.springframework.http.server.reactive.ServerHttpResponse
import org.springframework.stereotype.Component
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono

@Component
@Slf4j
class JwtAuthFilter: AbstractGatewayFilterFactory<JwtAuthFilter.Config> {
    private val log = LoggerFactory.getLogger(javaClass)

    @Autowired
    lateinit var jwtValidator: JwtValidator

    class Config {}

    constructor(): super(Config::class.java)

    fun handleUnAuthorized(res: ServerHttpResponse, errorCode: Int, status: HttpStatus): Mono<Void> {
        // TODO DTO 버퍼바디로 옮길 수 있는 메소드 만들기
        val responseDTO = ResponseDTO<Any>(errorCode, null)
        val mapper = ObjectMapper()
        val bytes: ByteArray = mapper.writeValueAsBytes(responseDTO)
        val buffer = res.bufferFactory().wrap(bytes)

        res.statusCode = status
        return res.writeWith(Mono.just(buffer))
    }

    override fun apply(config: Config): GatewayFilter {
        return GatewayFilter { exchange, chain ->
            var request: ServerHttpRequest = exchange.request
            var response: ServerHttpResponse = exchange.response

            val path = request.path.toString()

            val token: String = request.headers["Authorization"]?.get(0)?.substring(7) ?: ""

            if ((path != "/users/login") && (path != "/users/signup") && (path != "/users/refresh"))
            {
                if (token == "")
                {
                    return@GatewayFilter chain.filter(exchange).then(handleUnAuthorized(response, -1, HttpStatus.UNAUTHORIZED))
                }
                val tokenResultCode = jwtValidator.checkValidation(token)
                if (tokenResultCode < 0)
                {
                    return@GatewayFilter chain.filter(exchange).then(handleUnAuthorized(response, tokenResultCode, HttpStatus.BAD_REQUEST))
                }
            }

            // TODO 토큰 가지고 로그인 페이, 회원가입 페이지 들어갈 때 redirection 해줘야함 302 status code 넣어주기
            return@GatewayFilter chain.filter(exchange).then(Mono.fromRunnable {
            })
        }
    }
}