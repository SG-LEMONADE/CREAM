package com.cream.log.service

import com.cream.log.dto.UserLogDTO
import com.cream.log.persistence.UserLogRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import kotlin.streams.toList

@Service
class UserLogService {

    @Autowired
    lateinit var userLogRepository: UserLogRepository

    fun get(): List<UserLogDTO> {
        return userLogRepository.findAll().stream().map {
            UserLogDTO(it.userId, it.productId, it.action)
        }.toList()
    }

    fun create(
        userLogDTO: UserLogDTO
    ) {
        userLogRepository.save(userLogDTO.toEntity())
    }
}