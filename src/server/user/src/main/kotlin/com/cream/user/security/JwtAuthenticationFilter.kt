package com.cream.user.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.authority.AuthorityUtils
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.util.StringUtils
import org.springframework.web.filter.OncePerRequestFilter

import javax.servlet.FilterChain
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import lombok.extern.slf4j.Slf4j
import org.slf4j.LoggerFactory

@Slf4j
@Component
class JwtAuthenticationFilter: OncePerRequestFilter() {

    private val log = LoggerFactory.getLogger(javaClass)

    @Autowired
    lateinit var tokenProvider: TokenProvider

    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        try {
            val token: String? = parseBearerToken(request)
            if (token != null && !token.equals("null", ignoreCase = true)){
                val userId: String = tokenProvider.validateAndGetUserId(token)
                var authentication: AbstractAuthenticationToken = UsernamePasswordAuthenticationToken(
                    userId, null, AuthorityUtils.NO_AUTHORITIES
                )
                authentication.details = WebAuthenticationDetailsSource().buildDetails(request)
                var securityContext: SecurityContext = SecurityContextHolder.createEmptyContext()
                securityContext.authentication = authentication
                SecurityContextHolder.setContext(securityContext)
            }
        }
        catch(e: Exception){
            log.warn(e.message)
        }
        filterChain.doFilter(request, response)
    }

    fun parseBearerToken(request: HttpServletRequest): String? {
        val bearerToken: String = request.getHeader("Authorization")
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7)
        }
        return null
    }
}