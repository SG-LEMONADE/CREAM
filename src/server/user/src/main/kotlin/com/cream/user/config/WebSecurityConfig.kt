package com.cream.user.config

import com.cream.user.security.JwtAccessDeniedHandler
import com.cream.user.security.JwtAuthenticationEntryPoint
import com.cream.user.security.JwtAuthenticationFilter
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.web.filter.CorsFilter

@EnableWebSecurity
class WebSecurityConfig: WebSecurityConfigurerAdapter() {

    @Autowired
    lateinit var jwtAuthenticationFilter: JwtAuthenticationFilter

    @Autowired
    lateinit var jwtAccessDeniedHandler: JwtAccessDeniedHandler

    @Autowired
    lateinit var jwtAuthenticationEntryPoint: JwtAuthenticationEntryPoint

    override fun configure(http: HttpSecurity){
        http.cors()
            .and()
            .csrf().disable()
            .httpBasic().disable()
            .exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).accessDeniedHandler(jwtAccessDeniedHandler)
            .and()
            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            .and()
            .authorizeRequests().antMatchers("/users/login", "/users/signup", "/users/verify", "/users/refresh").permitAll()
            .anyRequest().authenticated()


        http.addFilterAfter(
            jwtAuthenticationFilter,
            CorsFilter::class.java
        )
    }
}