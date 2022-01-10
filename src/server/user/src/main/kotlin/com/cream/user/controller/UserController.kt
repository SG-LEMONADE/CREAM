package com.cream.user.controller

import com.cream.user.dto.*
import com.cream.user.model.UserEntity
import com.cream.user.security.TokenProvider
import com.cream.user.service.UserService
import lombok.extern.slf4j.Slf4j

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.http.HttpStatus
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
import kotlin.random.Random


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
    fun registerUser(@RequestBody registerUserDTO: RegisterUserDTO): ResponseEntity<Any>{
        var responseDTO: ResponseDTO<Any>
        return try{
            val user = registerUserDTO.toEntity(passwordEncoder)

            sendEmail(user.email, user.name, 0)

            val registeredUser: UserEntity = userService.create(user)
            val responseUserDTO = ResponseUserDTO(registeredUser, "")
            responseDTO = ResponseDTO(err = 0, data = responseUserDTO)
            ResponseEntity.ok().body(responseDTO)
        } catch (e: Exception){
            responseDTO = ResponseDTO(err = -10, data = e.message)
            ResponseEntity.badRequest().body(responseDTO)
        }
    }

    @PostMapping("/login")
    fun authenticate(@RequestBody userDTO: LoginDTO): ResponseEntity<Any>{
        var responseDTO: ResponseDTO<Any>

        return try {
            val user: UserEntity = userService.getByCredentials(userDTO.email, userDTO.password, passwordEncoder)

            when {
                (user.status == 0) ->
                {
                    // 이메일 인증 안됐을때
                    responseDTO = ResponseDTO(-1, null)
                    ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseDTO)
                }
                (user.status == 1) ->
                {
                    // 비밀번호를 반드시 바꾸어야 할 때
                    responseDTO = ResponseDTO(-2, null)
                    ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseDTO)
                }
                (user.status == 3) ->
                {
                    // 삭제된 유저 일때
                    responseDTO = ResponseDTO(-3, null)
                    ResponseEntity.status(HttpStatus.NOT_FOUND).body(responseDTO)
                }
            }

            val token: String = tokenProvider.create(user)
            val refreshToken: String = tokenProvider.create(user, isRefresh = true)

            val stringValueOperation = redisTemplate.opsForValue()
            stringValueOperation.set("refresh-${user.id}", refreshToken, 7, TimeUnit.DAYS)

            userService.updateUserLastLoginTime(user)

            val responseUserDTO = ResponseUserDTO(user, refreshToken)
            responseDTO = ResponseDTO(0, responseUserDTO)
            ResponseEntity.ok().header("Authorization", "Bearer $token").body(responseDTO)
        } catch (e: Exception) {
            responseDTO = ResponseDTO(err = -10, data = e.message)
            ResponseEntity.badRequest().body(responseDTO)
        }
    }

    @PostMapping("/checker")
    fun check(): HashMap<String, String> {
        val test: HashMap<String, String> = HashMap()
        test["test"] = "this is test"
        return test
    }

    @PostMapping("/refresh")
    fun generateNewToken(@RequestBody tokenDTO: RefreshDTO): ResponseEntity<Any>{
        var responseDTO: ResponseDTO<Any>
        return try{

            val accessToken: String = tokenDTO.accessToken
            val refreshToken: String = tokenDTO.refreshToken

            val userId = tokenProvider.validateAndGetUserId(refreshToken)
            if (tokenProvider.validateAndGetUserId(accessToken) != userId){
                // 엑세스 토큰과 리프레시 토큰이 다른 사람일때
                responseDTO = ResponseDTO(err = -1, null)
                ResponseEntity.badRequest().body(responseDTO)
            }

            val stringValueOperation = redisTemplate.opsForValue()
            val storedToken: String? = stringValueOperation.get("refresh-${userId}")
            if (storedToken == null || storedToken != refreshToken){
                responseDTO = ResponseDTO(err = -2, null)
                ResponseEntity.badRequest().body(responseDTO)
            }

            val user = userService.getById(userId.toLong())
            val newAccessToken = tokenProvider.create(user)
            val newRefreshToken = tokenProvider.create(user, isRefresh = true)

            stringValueOperation.set("refresh-${userId}", newRefreshToken, 7, TimeUnit.DAYS)
            val responseTokenDTO = RefreshDTO(newAccessToken,newRefreshToken)

            responseDTO = ResponseDTO(err = 0, responseTokenDTO)
            ResponseEntity.ok().header("Authorization", "Bearer $newAccessToken").body(responseDTO)
        } catch (e: Exception) {
            responseDTO = ResponseDTO(err = -10, data = e.message)
            ResponseEntity.badRequest().body(responseDTO)
        }
    }

    @GetMapping("/verify")
    fun verifyEmail(@RequestParam ("email", required = true) email: String, @RequestParam("hash", required = true) hash: String): ResponseEntity<Any>{
        var responseDTO: ResponseDTO<Any>
        return try{
            val stringValueOperation = redisTemplate.opsForValue()
            val storedHash: String? = stringValueOperation.get(email)
            if (storedHash == null || storedHash != hash) {
                throw Exception("hash value is not match")
            }

            userService.updateUserState(email, 2)

            responseDTO = ResponseDTO(0, null)
            ResponseEntity.ok().body(responseDTO)
        } catch (e: Exception){
            responseDTO = ResponseDTO(err = -10, data = null)
            ResponseEntity.badRequest().body(responseDTO)
        }
    }


    @Async
    fun sendEmail(email: String, name: String, type: Int) {
        val message: MimeMessage = javaMailSender.createMimeMessage()
        message.addRecipient(Message.RecipientType.TO, InternetAddress(email))
        message.subject = "[본인인증] Cream 이메일 인증"

        val randNum = (0..1000000).random()
        val formatted = String.format("%06d", randNum)
        val hash = getSHA512Token(formatted + name)
        val stringValueOperation = redisTemplate.opsForValue()
        var htmlString = ""
        stringValueOperation.set(email, hash, 1, TimeUnit.DAYS)
        if (type == 0)
        {
            htmlString +=
                "안녕하세요 ${name}님 인증을 위해 아래의 주소를 눌러주세요. " +
                        "<a href='http://localhost:8000/users/verify?email=${email}+key=${hash}'> 회원 가입 이메일 인증하기 </a>"
        }
        else if (type == 1)
        {
            htmlString +=
                "안녕하세요 ${name}님 비밀번호 변경을 위해 아래의 주소를 눌러주세요. " +
                        "<a href='http://localhost:8000/users/verify/password?email=${email}+key=${hash}'> 비밀번호 변경하기 </a>"
        }

        message.setText(htmlString)
        javaMailSender.send(message)
    }

    fun getSHA512Token(value: String): String {
        return try {
            val md = MessageDigest.getInstance("SHA-512")
            val messageDigest = md.digest(value.toByteArray())
            val no = BigInteger(1, messageDigest)
            var hashText = no.toString()
            while (hashText.length < 32) {
                hashText = "0$hashText"
            }
            hashText
        } catch (e: NoSuchAlgorithmException){
            throw RuntimeException(e)
        }
    }
}