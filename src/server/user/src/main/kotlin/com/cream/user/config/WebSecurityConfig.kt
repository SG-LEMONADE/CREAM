package com.cream.user.config

import com.cream.user.security.JwtAccessDeniedHandler
import com.cream.user.security.JwtAuthenticationEntryPoint
import com.cream.user.security.JwtAuthenticationFilter
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.web.filter.CorsFilter

@EnableWebSecurity
class WebSecurityConfig : WebSecurityConfigurerAdapter() {
    private val log = LoggerFactory.getLogger(javaClass)

    @Autowired
    lateinit var jwtAuthenticationFilter: JwtAuthenticationFilter

    @Autowired
    lateinit var jwtAccessDeniedHandler: JwtAccessDeniedHandler

    @Autowired
    lateinit var jwtAuthenticationEntryPoint: JwtAuthenticationEntryPoint

    @Value("\${auth-excluded-path}")
    lateinit var authExcludedPaths: Array<String>

    override fun configure(http: HttpSecurity) {
        http.cors()
            .and()
            .csrf().disable()
            .httpBasic().disable()
            .exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).accessDeniedHandler(jwtAccessDeniedHandler)
            .and()
            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            .and()
            .authorizeRequests().antMatchers(*authExcludedPaths).permitAll()
            .anyRequest().authenticated()

        http.addFilterAfter(
            jwtAuthenticationFilter,
            CorsFilter::class.java
        )
    }
}