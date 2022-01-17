package com.cream.user.security

import com.cream.user.model.UserEntity

import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import org.springframework.beans.factory.annotation.Value

import org.springframework.stereotype.Service
import java.math.BigInteger
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
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
        val claims: Claims = Jwts.parser()
            .setSigningKey(SECRET_KEY)
            .parseClaimsJws(filteredToken)
            .body
        return claims.subject
    }

    fun getSHA512Token(value: String): String {
        return try {
            val md = MessageDigest.getInstance("SHA-512")
            val messageDigest = md.digest(value.toByteArray())
            val no = BigInteger(1, messageDigest)
            var hashText = no.toString()
            while (hashText.length < 32) {
                hashText = "0$hashText"
            }
            hashText
        } catch (e: NoSuchAlgorithmException){
            throw RuntimeException(e)
        }
    }

}