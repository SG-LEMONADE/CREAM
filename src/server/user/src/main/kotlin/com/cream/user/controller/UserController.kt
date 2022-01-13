package com.cream.user.controller

import com.cream.user.dto.*
import com.cream.user.error.UserCustomException
import com.cream.user.error.ErrorCode
import com.cream.user.model.UserEntity
import com.cream.user.security.TokenProvider
import com.cream.user.service.UserService
import io.swagger.annotations.ApiOperation
import lombok.extern.slf4j.Slf4j
import org.slf4j.LoggerFactory

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.http.ResponseEntity
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder
import java.util.concurrent.TimeUnit

import org.springframework.scheduling.annotation.Async
import org.springframework.web.bind.annotation.*
import java.math.BigInteger
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import javax.mail.Message
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeMessage


@Slf4j
@RestController
@RequestMapping("/users")
class UserController {
    @Autowired
    lateinit var userService: UserService

    @Autowired
    lateinit var tokenProvider: TokenProvider

    @Autowired
    lateinit var redisTemplate: StringRedisTemplate

    @Autowired
    lateinit var javaMailSender: JavaMailSender

    var passwordEncoder: PasswordEncoder = BCryptPasswordEncoder()

    @PostMapping("/signup")
    fun signup(@RequestBody registerUserDTO: RegisterUserDTO): ResponseEntity<Any>{
        val user = registerUserDTO.toEntity(passwordEncoder)

        sendEmail(user.email, user.name, 0)

        return ResponseEntity.ok()
            .body(ResponseUserDTO(userService.create(user), ""))
    }

    @PostMapping("/login")
    fun login(@RequestBody userDTO: LoginDTO): ResponseEntity<Any>{
        val user: UserEntity = userService.getByCredentials(userDTO.email, userDTO.password, passwordEncoder)

        when {
            (user.status == 0) -> {
                // 이메일 인증 안됐을때
                throw UserCustomException(ErrorCode.USER_EMAIL_NOT_VERIFIED)
            }
            (user.status == 1) -> {
                // 비밀번호를 반드시 바꾸어야 할 때
                throw UserCustomException(ErrorCode.USER_NEED_TO_CHANGE_PASSWORD)
            }
            (user.status == 3) -> {
                // 삭제된 유저 일때
                throw UserCustomException(ErrorCode.USER_NOT_FOUND)
            }
        }

        val token: String = tokenProvider.create(user)
        val refreshToken: String = tokenProvider.create(user, isRefresh = true)
        val stringValueOperation = redisTemplate.opsForValue()
        stringValueOperation.set("refresh-${user.id}", refreshToken, 7, TimeUnit.DAYS)
        userService.updateUserLastLoginTime(user)

        return ResponseEntity.ok()
            .header("Authorization", "Bearer $token")
            .body(ResponseUserDTO(user, refreshToken))
    }

    @PostMapping("/test")
    fun test(): HashMap<String, String> {
        val log = LoggerFactory.getLogger(javaClass)
        log.info("this is called")
        val test: HashMap<String, String> = HashMap()
        test["test"] = "this is test"
        return test
    }

    @PostMapping("/refresh")
    fun refresh(@RequestBody tokenDTO: RefreshDTO): ResponseEntity<Any>{
        val accessToken: String = tokenDTO.accessToken
        val refreshToken: String = tokenDTO.refreshToken

        val userId = tokenProvider.validateAndGetUserId(refreshToken)
        if (tokenProvider.validateAndGetUserId(accessToken) != userId){
            // 엑세스 토큰과 리프레시 토큰이 다른 사람일때
            throw UserCustomException(ErrorCode.REFRESH_TOKEN_NOT_VALID)
        }

        val stringValueOperation = redisTemplate.opsForValue()
        val storedToken: String? = stringValueOperation.get("refresh-${userId}")
        if (storedToken == null || storedToken != refreshToken){
            throw UserCustomException(ErrorCode.REFRESH_TOKEN_EXPIRED)
        }

        val user = userService.getById(userId.toLong())
        val newAccessToken = tokenProvider.create(user)
        val newRefreshToken = tokenProvider.create(user, isRefresh = true)

        stringValueOperation.set("refresh-${userId}", newRefreshToken, 7, TimeUnit.DAYS)

        return ResponseEntity.ok()
            .header("Authorization", "Bearer $newAccessToken")
            .body(RefreshDTO(newAccessToken,newRefreshToken))
    }

    @PostMapping("/validate")
    fun validate(@RequestHeader("Authorization") token: String): ResponseEntity<Any> {
        return ResponseEntity.ok().body(null)
    }

    @GetMapping("/verify")
    fun verify(@RequestParam ("email", required = true) email: String, @RequestParam("key", required = true) hash: String): ResponseEntity<Any>{
        val stringValueOperation = redisTemplate.opsForValue()
        val storedHash: String? = stringValueOperation.get(email)
        if (storedHash == null || storedHash != hash) {
            throw UserCustomException(ErrorCode.EMAIL_HASH_NOT_VALID)
        }
        userService.updateUserState(email, 2)
        redisTemplate.delete(email)
        return ResponseEntity.ok().body(null)
    }

    @GetMapping("/me")
    fun me(@RequestHeader("Authorization") token: String): ResponseEntity<Any> {
        return ResponseEntity.ok()
            .body(ResponseUserDTO(userService.getById(tokenProvider.validateAndGetUserId(token).toLong()), ""))
    }

    @PostMapping("/logout")
    fun logout(@RequestHeader("Authorization") token: String): ResponseEntity<Any> {
            val userId = tokenProvider.validateAndGetUserId(token)
            redisTemplate.delete("refresh-${userId}")
            return ResponseEntity.ok().body(null)
    }

    @PutMapping("/{id}")
    fun update(@PathVariable id: Long,  @RequestBody updatedUser: UpdateUserDTO): ResponseEntity<Any> {
        val user = userService.update(userService.getById(id), updatedUser, passwordEncoder)
        return ResponseEntity.ok().body(ResponseUserDTO(user, ""))
    }

    @Async
    fun sendEmail(email: String, name: String, type: Int) {
        val message: MimeMessage = javaMailSender.createMimeMessage()
        message.addRecipient(Message.RecipientType.TO, InternetAddress(email))
        message.subject = "[본인인증] Cream 이메일 인증"

        val randNum = (0..1000000).random()
        val formatted = String.format("%06d", randNum)
        val hash = tokenProvider.getSHA512Token(formatted + name)
        val stringValueOperation = redisTemplate.opsForValue()
        var htmlString = ""
        stringValueOperation.set(email, hash, 1, TimeUnit.DAYS)
        if (type == 0)
        {
            htmlString +=
                "안녕하세요 ${name}님 인증을 위해 아래의 링크를 눌러주세요. \n" +
                        "<a href='http://localhost:8000/users/verify?email=${email}&key=${hash}'> 회원 가입 이메일 인증하기 </a>"
        }
        else if (type == 1)
        {
            htmlString +=
                "안녕하세요 ${name}님 비밀번호 변경을 위해 아래의 링크를 눌러주세요. \n" +
                        "<a href='http://localhost:8000/users/verify/password?email=${email}&key=${hash}'> 비밀번호 변경하기 </a>"
        }

        message.setText(htmlString, "UTF-8", "html")
        javaMailSender.send(message)
    }
}