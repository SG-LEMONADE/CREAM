package com.cream.product.config

import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext

// 영속성을 사용하는 entityManager를 통해 JPAQueryFactory로 Querydsl Query작성 가능
@Configuration
class QuerydlsConfig (@PersistenceContext val entityManager: EntityManager){
    @Bean
    fun jpaQueryFactory() = JPAQueryFactory(entityManager)
}