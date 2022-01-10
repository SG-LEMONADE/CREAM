package com.cream.user.security

import com.cream.user.dto.ResponseDTO
import com.fasterxml.jackson.databind.ObjectMapper
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
        val responseDTO = ResponseDTO<Any>(-1, null)
        val mapper = ObjectMapper()
        if (response != null) {
            response.contentType = "application/json"
            response.status = HttpServletResponse.SC_UNAUTHORIZED
            response.writer.write(mapper.writeValueAsString(responseDTO))
        }
    }
}