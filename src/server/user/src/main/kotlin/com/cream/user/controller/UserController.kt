package com.cream.user.controller

import com.cream.user.dto.*
import com.cream.user.service.UserService

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity

import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/users")
class UserController {
    @Autowired
    lateinit var userService: UserService

    @PostMapping("/join")
    fun join(
        @RequestBody registerUserDTO: RegisterUserDTO
    ): ResponseEntity<ResponseUserDTO> {
        return ResponseEntity.ok(
            userService.create(registerUserDTO)
        )
    }

    @PostMapping("/login")
    fun login(
        @RequestBody userDTO: LoginDTO
    ): ResponseEntity<TokenDTO> {
        return ResponseEntity.ok(
            userService.getValidationToken(userDTO)
        )
    }

    @PostMapping("/refresh")
    fun refresh(
        @RequestBody tokenDTO: TokenDTO
    ): ResponseEntity<TokenDTO> {
        return ResponseEntity.ok(
            userService.refreshToken(tokenDTO)
        )
    }

    @PostMapping("/validate")
    fun validate(
        @RequestHeader("Authorization") token: String
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(
            null
        )
    }

    @GetMapping("/verify")
    fun verify(
        @RequestParam("email", required = true) email: String,
        @RequestParam("key", required = true) hash: String
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(
            userService.verify(email, hash)
        )
    }

    @GetMapping("/me")
    fun me(
        @RequestHeader("Authorization") token: String
    ): ResponseEntity<ResponseUserDTO> {
        return ResponseEntity.ok(userService.getMe(token))
    }

    @PostMapping("/logout")
    fun logOut(
        @RequestHeader("Authorization") token: String
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(userService.logOut(token))
    }

    @PutMapping("/{id}")
    fun update(
        @PathVariable id: Long,
        @RequestBody updatedUser: UpdateUserDTO
    ): ResponseEntity<ResponseUserDTO> {
        return ResponseEntity.ok(userService.update(id, updatedUser))
    }
}