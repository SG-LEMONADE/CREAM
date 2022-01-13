package com.cream.user.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.authority.AuthorityUtils
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

import javax.servlet.FilterChain
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import lombok.extern.slf4j.Slf4j

@Slf4j
@Component
class JwtAuthenticationFilter: OncePerRequestFilter() {

    @Autowired
    lateinit var tokenProvider: TokenProvider

    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        val token: String? = request.getHeader("Authorization")
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
        filterChain.doFilter(request, response)
    }
}