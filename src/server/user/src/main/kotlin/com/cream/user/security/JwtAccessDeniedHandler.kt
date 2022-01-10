package com.cream.user.security

import com.cream.user.dto.ResponseDTO
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.security.access.AccessDeniedException
import org.springframework.security.web.access.AccessDeniedHandler
import org.springframework.stereotype.Component
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class JwtAccessDeniedHandler: AccessDeniedHandler{
    override fun handle(
        request: HttpServletRequest?,
        response: HttpServletResponse?,
        accessDeniedException: AccessDeniedException?
    ) {
        val responseDTO = ResponseDTO<Any>(-2, null)
        val mapper = ObjectMapper()
        if (response != null) {
            response.contentType = "application/json"
            response.status = HttpServletResponse.SC_NOT_ACCEPTABLE
            response.writer.write(mapper.writeValueAsString(responseDTO))
        }
    }
}