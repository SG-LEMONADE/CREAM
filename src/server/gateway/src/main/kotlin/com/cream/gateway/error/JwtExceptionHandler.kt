package com.cream.gateway.error

import com.fasterxml.jackson.databind.ObjectMapper
import io.jsonwebtoken.ExpiredJwtException
import io.jsonwebtoken.MalformedJwtException
import io.jsonwebtoken.SignatureException
import io.jsonwebtoken.UnsupportedJwtException
import org.slf4j.LoggerFactory
import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ServerWebExchange
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono
import java.nio.charset.StandardCharsets

@Service
class JwtExceptionHandler: ErrorWebExceptionHandler {
    private val log = LoggerFactory.getLogger(javaClass)
    private val mapper =  ObjectMapper()
    override fun handle(exchange: ServerWebExchange, ex: Throwable): Mono<Void> {

        ex.printStackTrace()

        var errCode = ErrorResponse(ErrorCode.INTERNAL_SERVER_ERROR)
        when (ex.javaClass) {
            NullPointerException::class.java -> {
                errCode = ErrorResponse(ErrorCode.USER_TOKEN_EMPTY)
            }
            ExpiredJwtException::class.java -> {
                errCode = ErrorResponse(ErrorCode.USER_TOKEN_EXPIRED)
            }
            MalformedJwtException::class.java, SignatureException::class.java, UnsupportedJwtException::class.java,
            NumberFormatException::class.java, LogoutTokenException::class.java, TokenInvalidException::class.java -> {
                errCode = ErrorResponse(ErrorCode.USER_TOKEN_NOT_VALID)
            }
            IllegalArgumentException::class.java -> {
                errCode = ErrorResponse(ErrorCode.INVALID_INPUT_VALUE)
            }
        }

        log.error(errCode.message)

        val bytes: ByteArray = mapper.writeValueAsString(errCode).toByteArray(StandardCharsets.UTF_8)
        val buffer = exchange.response.bufferFactory().wrap(bytes)
        exchange.response.statusCode = HttpStatus.valueOf(errCode.status)
        exchange.response.headers.add("Content-Type", "application/json")
        return exchange.response.writeWith(Flux.just(buffer))
    }
}
