package com.cream.product.config

import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class JacksonConfig {

    @Bean
    fun hibernate5Module(): Hibernate5Module {
        // Hibernate5Module이 지연로딩 되는 객체의 프로퍼티 값이 비어있더라도 직렬화를 가능하게 해준다.
        // 이 모듈을 bean으로 등록 안하면 hibernateLazyInitializer 라는 하이버네이트 프록시 객체의 프로퍼티를 직렬화 하려다가 에러남
        return Hibernate5Module()
    }
}