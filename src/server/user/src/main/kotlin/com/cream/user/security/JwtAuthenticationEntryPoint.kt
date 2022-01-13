package com.cream.user.security

import com.cream.user.error.ErrorCode
import com.cream.user.error.ErrorResponse
import com.fasterxml.jackson.databind.ObjectMapper
import org.slf4j.LoggerFactory
import org.springframework.security.core.AuthenticationException
import org.springframework.security.web.AuthenticationEntryPoint
import org.springframework.stereotype.Component
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class JwtAuthenticationEntryPoint: AuthenticationEntryPoint {

    override fun commence(
        request: HttpServletRequest?,
        response: HttpServletResponse?,
        authException: AuthenticationException?
    ) {
        val errorResponse = ErrorResponse(ErrorCode.USER_ACCESS_DENIED)
        if (response != null) {
            response.contentType = "application/json"
            response.status = HttpServletResponse.SC_UNAUTHORIZED
            response.writer.write(ObjectMapper().writeValueAsString(errorResponse))
        }
    }
}