package com.cream.user.security

import com.cream.user.error.ErrorCode
import com.cream.user.error.ErrorResponse
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.security.access.AccessDeniedException
import org.springframework.security.web.access.AccessDeniedHandler
import org.springframework.stereotype.Component
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class JwtAccessDeniedHandler : AccessDeniedHandler {

    override fun handle(
        request: HttpServletRequest?,
        response: HttpServletResponse?,
        accessDeniedException: AccessDeniedException?
    ) {
        val errorResponse = ErrorResponse(ErrorCode.USER_TOKEN_NOT_VALID)
        if (response != null) {
            response.contentType = "application/json"
            response.status = HttpServletResponse.SC_UNAUTHORIZED
            response.writer.write(ObjectMapper().writeValueAsString(errorResponse))
        }
    }
}