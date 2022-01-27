package com.cream.user.utils

import com.cream.user.security.TokenProvider
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.scheduling.annotation.Async
import org.springframework.stereotype.Component
import java.util.concurrent.TimeUnit
import javax.mail.Message
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeMessage

@Component
class MailSender {

    @Autowired
    lateinit var javaMailSender: JavaMailSender

    @Autowired
    lateinit var tokenProvider: TokenProvider

    @Autowired
    lateinit var redisTemplate: StringRedisTemplate

    @Async
    fun sendEmail(email: String, type: Int) {
        val message: MimeMessage = javaMailSender.createMimeMessage()
        message.addRecipient(Message.RecipientType.TO, InternetAddress(email))
        message.subject = "[본인인증] Cream 이메일 인증"

        val randNum = (0..1000000).random()
        val formatted = String.format("%06d", randNum)
        val hash = tokenProvider.getSHA512Token(formatted + email)
        val stringValueOperation = redisTemplate.opsForValue()
        var htmlString = ""
        stringValueOperation.set(email, hash, 1, TimeUnit.DAYS)
        if (type == 0) {
            htmlString +=
                "안녕하세요 인증을 위해 아래의 링크를 눌러주세요. \n" +
                "<a href='http://localhost:8000/users/verify?email=$email&key=$hash'> 회원 가입 이메일 인증하기 </a>"
        } else if (type == 1) {
            htmlString +=
                "안녕하세요 비밀번호 변경을 위해 아래의 링크를 눌러주세요. \n" +
                "<a href='http://localhost:8000/users/verify/password?email=$email&key=$hash'> 비밀번호 변경하기 </a>"
        }

        message.setText(htmlString, "UTF-8", "html")
        javaMailSender.send(message)
    }
}