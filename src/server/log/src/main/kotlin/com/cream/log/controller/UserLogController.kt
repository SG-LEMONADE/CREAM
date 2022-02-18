package com.cream.log.controller

import com.cream.log.dto.UserLogDTO
import com.cream.log.service.UserLogService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/log")
class UserLogController {

    @Autowired
    lateinit var userLogService: UserLogService

    @PostMapping
    fun createUserLog(
        @RequestBody userLogDTO: UserLogDTO
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(userLogService.create(userLogDTO))
    }
}