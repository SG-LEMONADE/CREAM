package com.cream.user.security

import com.cream.user.model.UserEntity

import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import org.springframework.beans.factory.annotation.Value

import org.springframework.stereotype.Service
import java.util.Date
import java.time.Instant
import java.time.temporal.ChronoUnit


@Service
class TokenProvider {

    @Value("\${secret-key}")
    lateinit var SECRET_KEY: String

    fun create(userEntity: UserEntity, isRefresh: Boolean=false): String{
        var expiryDate: Date = Date.from(Instant.now().plus(30, ChronoUnit.MINUTES))

        if (isRefresh){
            expiryDate = Date.from(Instant.now().plus(7, ChronoUnit.DAYS))
        }
        return Jwts.builder()
            .signWith(SignatureAlgorithm.HS512, SECRET_KEY)
            .setSubject(userEntity.id.toString())
            .setIssuer("cream-app")
            .setExpiration(expiryDate)
            .compact()
    }

    fun validateAndGetUserId(token: String): String{
        val filteredToken = token.substring(7) // without Bearer
        var claims: Claims = Jwts.parser()
            .setSigningKey(SECRET_KEY)
            .parseClaimsJws(filteredToken)
            .body
        return claims.subject
    }
}