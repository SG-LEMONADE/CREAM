package com.cream.user.error

import io.jsonwebtoken.MalformedJwtException
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.http.converter.HttpMessageNotReadableException
import org.springframework.validation.BindException
import org.springframework.web.HttpRequestMethodNotSupportedException
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.MissingRequestHeaderException
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException

@RestControllerAdvice
class GlobalExceptionHandler {

    private val log = LoggerFactory.getLogger(javaClass)

    @ExceptionHandler(UserCustomException::class)
    fun handleUserCustomException(ex: UserCustomException): ResponseEntity<ErrorResponse> {
        log.error("UserCustomException: ${ex.errorCode.message}")
        val response = ErrorResponse(ex.errorCode)
        return ResponseEntity(response, HttpStatus.valueOf(ex.errorCode.status))
    }

    @ExceptionHandler(MethodArgumentNotValidException::class)
    fun handleMethodArgumentNotValidException(ex: MethodArgumentNotValidException): ResponseEntity<ErrorResponse> {
        log.error("MethodArgumentNotValidException", ex)
        val response = ErrorResponse(ErrorCode.INVALID_INPUT_VALUE)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(MissingRequestHeaderException::class)
    fun handleMissingRequestHeaderException(ex: MissingRequestHeaderException): ResponseEntity<ErrorResponse> {
        log.error("MissingRequestHeaderException", ex)
        val response = ErrorResponse(ErrorCode.INVALID_INPUT_VALUE)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException::class)
    fun handleMethodArgumentTypeMismatchException(ex: MethodArgumentTypeMismatchException): ResponseEntity<ErrorResponse> {
        log.error("MethodArgumentTypeMismatchException", ex)
        val response = ErrorResponse(ErrorCode.INVALID_INPUT_VALUE)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(BindException::class)
    fun handleBindException(ex: BindException): ResponseEntity<ErrorResponse> {
        log.error("BindException", ex)
        val response = ErrorResponse(ErrorCode.INVALID_INPUT_VALUE)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(HttpMessageNotReadableException::class)
    fun handleBindException(ex: HttpMessageNotReadableException): ResponseEntity<ErrorResponse> {
        log.error("HttpMessageNotReadableException", ex)
        val response = ErrorResponse(ErrorCode.INVALID_INPUT_VALUE)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(MalformedJwtException::class)
    fun handleMalformedJwtException(ex: MalformedJwtException): ResponseEntity<ErrorResponse> {
        log.error("HttpMessageNotReadableException", ex)
        val response = ErrorResponse(ErrorCode.USER_TOKEN_NOT_VALID)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException::class)
    fun handleHttpRequestMethodNotSupportedException(ex: HttpRequestMethodNotSupportedException): ResponseEntity<ErrorResponse> {
        log.error("HttpMessageNotReadableException", ex)
        val response = ErrorResponse(ErrorCode.METHOD_NOT_ALLOWED)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(Exception::class)
    fun handleException(ex: Exception): ResponseEntity<ErrorResponse> {
        log.error("Exception ", ex)
        val response = ErrorResponse(ErrorCode.INTERNAL_SERVER_ERROR)
        return ResponseEntity(response, HttpStatus.INTERNAL_SERVER_ERROR)
    }
}