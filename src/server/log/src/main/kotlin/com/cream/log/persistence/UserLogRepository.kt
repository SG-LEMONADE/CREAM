package com.cream.log.persistence

import com.cream.log.model.UserLog
import org.springframework.data.mongodb.repository.MongoRepository

interface UserLogRepository : MongoRepository<UserLog, String>