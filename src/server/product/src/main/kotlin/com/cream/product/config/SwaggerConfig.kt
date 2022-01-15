package com.cream.product.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import springfox.documentation.builders.ApiInfoBuilder
import springfox.documentation.builders.PathSelectors
import springfox.documentation.builders.RequestHandlerSelectors
import springfox.documentation.service.ApiInfo
import springfox.documentation.spi.DocumentationType
import springfox.documentation.spring.web.plugins.Docket
import springfox.documentation.swagger2.annotations.EnableSwagger2

@Configuration
@EnableSwagger2
class SwaggerConfig {

    @Bean
    fun docket(): Docket{
        val groupName: String = "CreamServer"
        return Docket(DocumentationType.SWAGGER_2)
            .useDefaultResponseMessages(false)
            .select()
            .apis(RequestHandlerSelectors.basePackage("com.cream.product.controller"))
            .paths(PathSelectors.any())
            .build()
            .groupName(groupName)
            .apiInfo(apiInfo())
    }

    private fun apiInfo(): ApiInfo{
        return ApiInfoBuilder()
            .title("CREAM API")
            .description("this is cream swagger for lemonade team")
            .version("1.0.0")
            .license("MIT License")
            .build()
    }
}