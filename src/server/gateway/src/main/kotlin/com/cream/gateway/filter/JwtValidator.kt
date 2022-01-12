package com.cream.gateway.filter

import io.jsonwebtoken.*
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class JwtValidator {
    private val log = LoggerFactory.getLogger(javaClass)

    @Value("\${secret-key}")
    lateinit var SECRET_KEY: String

    fun checkValidation(token: String): Int  {
        var resultCode: Int = 0
        try{
            Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).body.subject.toInt()
        } catch (e: Exception) {
            when (e) {
                is ExpiredJwtException -> {
                    log.warn("token is expired")
                    resultCode = -2
                }
                is SignatureException -> {
                    log.warn("signature is not correct")
                    resultCode = -3
                }
                is MalformedJwtException, is UnsupportedJwtException, is IllegalArgumentException,
                is NullPointerException, is NumberFormatException -> {
                    log.warn("token is not valid")
                    resultCode = -4
                }
            }
        }
        return resultCode
    }

    fun getUserIdFromToken(token: String): Int {
        return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).body.subject.toInt()
    }
}