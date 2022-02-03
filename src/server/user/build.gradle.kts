import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "2.6.2"
    id("io.spring.dependency-management") version "1.0.11.RELEASE"
    kotlin("jvm") version "1.6.10"
    kotlin("plugin.spring") version "1.6.10"
    kotlin("plugin.jpa") version "1.6.10"

    //ktlint
    id("org.jlleitschuh.gradle.ktlint") version "10.0.0"
    id("org.jlleitschuh.gradle.ktlint-idea") version "10.0.0"
}

group = "com.cream"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_11

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web:2.6.2")

    //jpa
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")

    //security
    implementation("org.springframework.boot:spring-boot-starter-security")

    //kotlin, lombok
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

    //db
    implementation("mysql:mysql-connector-java:8.0.27")
    implementation("org.springframework.boot:spring-boot-starter-data-redis:2.6.2")

    //swagger
    implementation("io.springfox:springfox-swagger2:3.0.0")
    implementation("io.springfox:springfox-swagger-ui:2.9.2")

    //mail
    implementation("org.springframework.boot:spring-boot-starter-mail:2.6.2")
    implementation("org.springframework:spring-context-support:5.3.14")

    // jwt
    implementation("io.jsonwebtoken:jjwt:0.9.1")

    //eureka
    implementation("org.springframework.cloud:spring-cloud-starter-netflix-eureka-client:3.1.0")

    // devtool,  test
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "11"
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}