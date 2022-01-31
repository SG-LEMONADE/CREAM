package com.cream.product.error

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

    @ExceptionHandler(BaseException::class)
    fun handleBaseException(ex: BaseException): ResponseEntity<ErrorResponse> {
        log.error(ex.code.message)
        return ResponseEntity(ErrorResponse(ex.code), HttpStatus.valueOf(ex.code.status))
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

    @ExceptionHandler(HttpRequestMethodNotSupportedException::class)
    fun handleHttpRequestMethodNotSupportedException(ex: HttpRequestMethodNotSupportedException): ResponseEntity<ErrorResponse> {
        log.error("HttpMessageNotReadableException", ex)
        val response = ErrorResponse(ErrorCode.METHOD_NOT_ALLOWED)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(NullPointerException::class)
    fun handleNullPointerException(ex: NullPointerException): ResponseEntity<ErrorResponse> {
        log.error("NullPointerException", ex)
        val response = ErrorResponse(ErrorCode.ENTITY_NOT_FOUND)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(NoSuchElementException::class)
    fun handleNoSuchElementException(ex: NoSuchElementException): ResponseEntity<ErrorResponse> {
        log.error("NoSuchElementException", ex)
        val response = ErrorResponse(ErrorCode.ENTITY_NOT_FOUND)
        return ResponseEntity(response, HttpStatus.valueOf(response.status))
    }

    @ExceptionHandler(Exception::class)
    fun handleUnexpectedException(ex: Exception): ResponseEntity<ErrorResponse> {
        log.error(ex.toString())
        return ResponseEntity(ErrorResponse(ErrorCode.INTERNAL_SERVER_ERROR), HttpStatus.INTERNAL_SERVER_ERROR)
    }
}