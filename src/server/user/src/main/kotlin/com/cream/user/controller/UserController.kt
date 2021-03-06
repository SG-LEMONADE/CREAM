package com.cream.user.controller

import com.cream.user.dto.*
import com.cream.user.service.UserService

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity

import org.springframework.web.bind.annotation.*
import javax.validation.Valid

@RestController
@RequestMapping("/users")
class UserController {
    @Autowired
    lateinit var userService: UserService

    @PostMapping("/join")
    fun join(
        @RequestBody @Valid registerUserDTO: RegisterUserDTO
    ): ResponseEntity<ResponseUserDTO> {
        return ResponseEntity.ok(userService.create(registerUserDTO))
    }

    @PostMapping("/login")
    fun login(
        @RequestBody userDTO: LoginDTO
    ): ResponseEntity<TokenDTO> {
        return ResponseEntity.ok(userService.getValidationToken(userDTO))
    }

    @PostMapping("/refresh")
    fun refresh(
        @RequestBody tokenDTO: RefreshTokenDTO
    ): ResponseEntity<TokenDTO> {
        return ResponseEntity.ok(userService.refreshToken(tokenDTO))
    }

    @GetMapping("/validate")
    fun validate(
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(null)
    }

    @GetMapping("/me")
    fun me(
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<ResponseUserDTO> {
        return ResponseEntity.ok(userService.getMe(userId))
    }

    @GetMapping("/verify")
    fun verify(
        @RequestParam("email", required = true) email: String,
        @RequestParam("key", required = true) hash: String
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(userService.verify(email, hash))
    }

    @PostMapping("/logout")
    fun logout(
        @RequestHeader("Authorization") token: String
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(userService.logout(token))
    }

    @PatchMapping("/{id}")
    fun update(
        @PathVariable id: Long,
        @RequestBody @Valid updatedUser: UpdateUserDTO
    ): ResponseEntity<ResponseUserDTO> {
        return ResponseEntity.ok(userService.update(id, updatedUser))
    }
}