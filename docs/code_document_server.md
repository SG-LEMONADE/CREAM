# Cream Server
## Index
- [Cream Server](#cream-server)
  - [Index](#index)
  - [Server 주요 코드](#server-주요-코드)
    - [Directory](#directory)
    - [Architecture](#architecture)
    - [Common](#common)
    - [user server](#user-server)
    - [product server](#product-server)
    - [log server](#log-server)
  - [설계 및 구현](#설계-및-구현)
    - [프로젝트 구현 사항 및 선정 이유](#프로젝트-구현-사항-및-선정-이유)
      - [Kotlin](#kotlin)
        - [코틀린을 사용한 이유](#코틀린을-사용한-이유)
        - [코틀린 구현 사항](#코틀린-구현-사항)
      - [스프링](#스프링)
      - [스프링을 사용한 이유](#스프링을-사용한-이유)
      - [JPA를 사용한 이유](#jpa를-사용한-이유)
      - [스프링 구현 사항](#스프링-구현-사항)
      - [JPA 구현 사항](#jpa-구현-사항)
    - [MSA](#msa)
    - [개인화 추천](#개인화-추천)
      - [상품 데이터 제작](#상품-데이터-제작)
      - [유저 데이터 제작](#유저-데이터-제작)
        - [어떻게 하면 진짜 비지니스에서 사용 가능한 그럴듯한 유저데이터를 만들 수 있을까?](#어떻게-하면-진짜-비지니스에서-사용-가능한-그럴듯한-유저데이터를-만들-수-있을까)
    - [개인화 된 추천](#개인화-된-추천)
  - [그외 고민들](#그외-고민들)

## Server 주요 코드

### Directory

``` c
server
├── db
│   └── create_table.sql // 데이터 베이스 생성 sql 파일
├── eureka
│   └── src
│       ├── main
│       │   ├── kotlin
│       │   └── resources
│       └── test
│           └── kotlin
├── gateway
│   └── src
│       ├── main
│       │   ├── kotlin
│       │   └── resources
│       └── test
│           └── kotlin
├── log
│   ├── HELP.md
│   └── src
│       ├── main
│       │   ├── kotlin
│       │   └── resources
│       └── test
│           └── kotlin
├── product
│   └── src
│       ├── main
│       │   ├── kotlin
│       │   └── resources
│       └── test
│           └── kotlin
├── recommendation
└── user
    └── src
        ├── main
        │   ├── kotlin
        │   └── resources
        └── test
            └── kotlin
```

### Architecture

### Common

크림 프로젝트의 서버 간단한 개요와 기술스택에 대해 설명합니다.

모든 프로젝트는 코틀린 언어를 기반으로한 스프링 프레임워크를 사용했습니다.

gateway와 eureka를 제외한 모든 프로젝트에 공통적인 특징으로 같은 형식의 프로젝트 구성을 가지고 있습니다.

- **model** - Entity들을 저장하고 있는 패키지 입니다.
- **persistence** - db와 연결을 위한 repository들이 모여있는 패키지 입니다.
- **dto** - request, response를 위한 자료형과 repository에서 가져오는 자료형을 담기 위한 data class들 입니다.
- **error** - 에러 핸들링하기 위한 response class와 에러 타입들이 들어가 있습니다.
- **service** - 비지니스 로직을 해결하기 위한 service 파일들입니다. repository에서 가져온 자료형을 바탕으로 자료를 종합하고 원하는 형태로 변경하는 작업을 수행합니다.
- **controller** - api 주소를 연결하는 controller 파일들이 담겨있습니다.
- **resources** - 설정파일로 application.yml파일이 존재합니다. yml파일을 선택한 이유는 간결하고 가독성이 properties 형식의 파일보다 좋다고 생각되어 선택했습니다.

추가적으로 협업을 위한 swagger를 모든 프로젝트에 등록해서 사용중에 있습니다.

### user server

인증, 유저 정보를 처리하는 서버입니다.
JWT 방식의 인증을 사용하고 있습니다.

데이터 베이스는 mysql과 redis를 사용하고 있습니다.
redis는 이메일 인증, refresh 토큰 저장용도와 로그아웃 후 쓰지 않는 토큰을 관리하는 용도로 사용하고 있습니다.

인증 부분에서 redis를 사용한 가장 큰 이유는 만료 시간을 쉽게 설정해 인증을 좀 더 편리하고 안전하게 해 줄 수 있다는 장점으로 사용했습니다.

[주요 코드 - 이메일 인증 (verify), 토큰 재발급 (refresh), 로그 아웃 (logout)](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/server/user/src/main/kotlin/com/cream/user/service/UserService.kt)

유저 회원가입 이메일 인증을 위한 spring-boot-starter-mail 라이브러리를 사용했습니다. 레퍼런스를 참고해 작성했습니다. 많은 이메일 라이브러리중 최근까지 업데이트 되는 것을 확인하고 사용하게 되었습니다.

[주요 코드 - 이메일 전송](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/server/user/src/main/kotlin/com/cream/user/utils/UserMailSender.kt)

토큰을 생성하기 위해 Spring Security를 사용중에 있습니다. 스프링 시큐리티를 사용해서 일일이 보안 관련 로직을 직접 작성하지 않아도 되는 장점이 있어 사용했습니다.

### product server

상품과 거래를 처리하는 서버입니다.

상품 데이터와 거래 관련해서 가격 설정 등 복잡한 구조가 많았기에 쿼리문을 유지보수, 가독성, 변경하기 용이하게 하기 위해 Querydsl을 이용했습니다. 특히 Querydsl을 통해 상품 검색 필터를 손쉽게 변경 및 사용이 가능하게 만들었습니다.

또한 상품의 가격이 변동되는 것, 유저가 사이즈 별로 찜을 할 수 있는 것을 고려해 모델을 설계하였고 기간 내 유효한 거래의 최저 가격을 가져오게 제작하였습니다.

상품 목록과 같이 한 번에 많은 객체를 불러 올 때 여러번 쿼리문을 호출하지 않도록 쿼리를 만들기 위해 구조를 고민했습니다.

 mysql만 사용하고 있으며 log서버와 연동되어 유저들의 행동 데이터를 저장 할 수 있게 제작했습니다. Mysql을 사용한 이유는 다음과 같습니다.

- 선택할 수 있는 Rdbms 중 mssql, postgreSql, mysql 중 mssql은 윈도우 환경에만 적합해서 제외를 했고, postgreSql과 mysql 중 고민을 했습니다.
- 우선적으로 postgreSql보다 Mysql을 이용해서 프로젝트를 진행한 경험이 있었기에 스프링과 코틀린에 더 집중하기 위해 익숙한 Mysql을 선택했습니다.

특히 많은 api가 있는 부분이기 때문에 조금이라도 더 효율적인 쿼리문과 데이터베이스 모델을 짜는 것에 집중한 서버입니다.

[주요 코드 - 상품 관련 repository](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/server/product/src/main/kotlin/com/cream/product/persistence/ProductRepository.kt)

[주요 코드 - 거래 관련 repository](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/server/product/src/main/kotlin/com/cream/product/persistence/TradeRepository.kt)

### log server

유저의 활동 로그 저장과 상품 상세 페이지에서 보여지는 그래프를 그리기 위한 상품의 1개월, 3개월, 6개월, 1년전의 가격을 날짜단위로 반환해 줍니다.

유저 정보와 상품의 가격정보들을 반환해 주기 위해 mongodb를 이용해 저장하고 있습니다. 또한 유저가 상품 서버 api를 호출한다면 활동 로그를 기록할 수 있게 feign client를 사용했습니다.

유레카 서버에만 등록을 해두면 쉽게 사용할 수 있고 성능도 준수하기 때문에 resttemplate를 사용하지 않았습니다.

추가적으로 mongodb의 유저 정보를 이용해 주기적으로 유저별 개인화 추천화 된 상품들의 정보를 저장하고 있습니다.
mongodb를 사용한 이유는 다음과 같습니다.

- 로그 데이터와 같이 확장성이 높은 것들은 관계형보다는 문서형 no-sql을 사용하는 것이 성능면으로도 확장을 고려해도 훨씬 좋을 것이라 생각했습니다.
- 여러 문서형 데이터베이스 중 가장 레퍼런스와 다양한 workbench가 많은 mongodb를 선택했습니다.

## 설계 및 구현

### 프로젝트 구현 사항 및 선정 이유

#### Kotlin

##### 코틀린을 사용한 이유

- 스프링을 경험한 적이 없는 저에게 많은 레퍼런스(자바)를 볼 때에 코틀린으로 스스로 변환하는 과정을 거치면서 그냥 코드를 배껴 적는 것보다 스프링의 특징을 더욱 깊게 이해 할 수 있는 기회가 될것이라 생각했습니다.
- 자바의 장황한 문법보다 간결한 코틀린을 선호해 꼭 서버 사이드에 사용해 보고 싶었습니다.
- jetbrain의 제품들을 애용하고 있어서 코틀린에 대한 관심이 높았습니다.
- 현재에도 몇몇 기업들이 코틀린으로 변환하고 있는데, 실제 그것이 유효한 결정인지 직접 확인해 보고 싶었습니다.

##### 코틀린 구현 사항

버전은 1.6.1을 이용하여 구현하였고 코틀린의 컨벤션을 지키기 위해 ktlint를 프로젝트 별로 설정해 사용했습니다.

자바 스프링과의 가장 큰 차이점이라고 한다면 **lombok을 전혀 사용하지 않고도 스프링 프레임워크를 사용할 수 있다는 것**이 가장 큰 차이점이라고 생각합니다.

**data class**라는 코틀린만의 클래스를 이용하여 getter, setter없이도 dto를 쉽게 제작 할 수 있습니다. (다만 entity는 data class를 사용해서는 안됩니다. 관련된 내용은 링크를 참고해 주시면됩니다.)

이로써 장황한 java와 builder메소드 없이 간결하게 클래스를 작성하거나 변경이 가능해 졌습니다.

다만 자바를 학교 수업과 코딩테스트에 사용했던 경험이 있어서 익숙했지만, kotlin은 처음 접하는 것이기 때문에 처음에는 작업속도가 문법 때문에 더뎌진 경험이 있습니다. 관련되어서는 아래 링크를 통해 코틀린의 특징과 코틀린 + 스프링 조합에 관련된 이슈들을 정리해 놓았습니다.

결론적으로 제가 코틀린으로 선택한 마지막 이유에 대한 답변은 충분히 코틀린으로 스프링을 제작 할만하다라는 생각이 들었습니다. 다만 굳이 만들어져있는 프로젝트들을 많은 리소스를 들여가면서까지는 포팅은 하지 않아도 될 거 같다는 결론을 얻게 되었습니다.

#### 스프링

#### 스프링을 사용한 이유

- 스마일 게이트 스토브에 전환되는 것이 팀 목표 중 하나였습니다. 현재 스토브 역시도 스프링을 사용하기 때문에 충분히 어필 될 수 있다고 생각했습니다.
- 서버 개발자의 커리어를 다른 프레임워크로 시작한 저로써는 스프링 프로젝트에 대한 갈망이 항상 존재했기 때문에 기회가 될 때 확실히 배워두고 싶었습니다.
- 국내 뿐만 아니라 해외에서도 너무나도 많은 레퍼런스가 존재하기 때문에 다양한 문제들을 쉽게 해결 할 수 있기에 선택했습니다.
- 스프링 부트와 스프링 클라우드 프로젝트들을 이용한다면 빠른 시간안에 MSA를 구축 할 수 있겠다는 생각을 했습니다.

#### JPA를 사용한 이유

- 다른 프레임워크들을 사용하면서 ORM과 Spring의 Hibernate와 같이 프로시져를 직접 작성하는 방법을 모두 사용해본 경험 상, Orm의 생산성이 훨씬 좋기에 선택했습니다.
- 실제로 많은 기업들이 Hibernate에서 Jpa로 넘어가는 추세이기 때문에 직접 Jpa를 경험해 보고 싶다는 생각으로 사용하게 되었습니다.

#### 스프링 구현 사항

스프링 부트를 사용하였고 최신 버전인 2.6.2버전을 사용했습니다. 스프링 클라우드 프로젝트 최신 버전과 함께 스프링 부트 역시도 최신버전으로 사용했습니다.
 Java는 11을 사용했습니다. 8과 비교해서 안정성도 동일하고 compile 명령어를 따로 하지 않아도 컴파일 및 실행시킬 수 있다는 점때문에 Java 11을 사용했습니다.

#### JPA 구현 사항

ORM 뿐만 아니라 다양한 상황에 유연하게 대처하기 위해 Querydsl이라는 라이브러리도 같이 사용했습니다.

### MSA

점점 현업에서는 프로젝트들의 규모가 커지면서 MSA에 대한 것들도 같이 조명받고 있습니다. 하지만 개인적으로는 MSA에 대한 개념 정도만 알고 있었고 실제 마이크로하게 작성한 적이 없었습니다.

그래서 이번 프로젝트에서는 MSA를 실제로 구현하고 경험해 장단점을 직접 체험해 보는 것 또한 하나의 목표였습니다. 실제로 프로젝트 규모상 MSA를 적용하지 않아도 충분하였지만 실제 경험을 통해 성장하기 위해 적용한 이유가 가장 컸습니다.

MSA를 구현하기 위해 스프링 클라우드 프로젝트를 이용했습니다.
사용한 프로젝트로는 **Spring cloud gateway**(ver 3.1.0),
**Spring cloud netflix eureka**(ver 3.1.0), **Spring cloud openfeign**(ver 3.1.0)
세 가지로 각각의 목적은 게이트웨이, 디스커버리 서버, 서버간 통신 라이브러리 입니다.

스프링 클라우드 프로젝트들의 Train Version은 Jubilee이고 스프링 부트 프로젝트의 버전은 2.6.2입니다.

실제로 스프링 클라우드 프로젝트들이 너무 구현이 잘되어 있어 성능상 이슈가 거의 발견되지 않을 정도로 서버간 통신이나 로드밸런싱 같은 것들이 쉽게 구현이 가능했습니다.

다만, 어떠한 단위로 서버를 나누어야 할지에 대한 고민이 조금 더 깊게 이루어 지고 프로젝트를 진행했으면 어땠을까 하는 아쉬움이 남습니다.

제가 MSA를 구현 하면서 부족했던 점은 다음과 같습니다.

1. 개인적으로 느끼기에 많은 부분이 product server에 집중되어 있다는 느낌이 들었습니다. 조금 더 데이터베이스 모델을 MSA에 맞추어 고려를 하고 작성을 했다면 충분히 분리 할 수 있었지 않았을까 하는 아쉬움이 남습니다.
2. log 서버에서는 현재 추천을 같이 진행하고 있습니다. 많은 유저 데이터들을 서버를 따로 분리해 보내는 것보다는 차라리 log 서버에서 있는 데이터를 직접 이용해서 계산하는 것이 성능상 이슈가 없을 것이라 판단했습니다. 대용량 파일을 주고 받을 때를 대비하지 못한 구조라는 아쉬움이 남습니다.

MSA를 구현하면서 만족했던 점은 다음과 같습니다.

1. 클라우드 프로젝트를 이용하긴 했지만 로드밸런싱과 서버간 통신이 예상 이상으로 원활하게 진행되었다는 점입니다.
2. 게이트웨이를 통해 통합 인증 구현을 잘 해냈습니다.
3. 실제 비지니스를 위한 MSA 구축시 고려해야 될 점들을 배운 경험이었습니다.

[Spring Cloud Gateway - 글로벌 인증 필터](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/server/gateway/src/main/kotlin/com/cream/gateway/filter/JwtAuthFilter.kt)
[Spring Cloud Eureka](https://github.com/SG-LEMONADE/CREAM/tree/develop/src/server/eureka)

### 개인화 추천

#### 상품 데이터 제작

총 상품 데이터는 1592개로 크롤링을 통해 크림에서 데이터를 추출했습니다.
카테고리는 5개로
“sneakers”, “life”, “streetwear”, “electronics”, “accessories”, "premium_bags" 로 구성되어 있습니다. 각 카테고리 별 개수로는 (629, 361, 76, 154, 356, 6)개로 구성 되어 있습니다.

각 상품들은 색깔과 gender라는 속성이 있어 남성, 여성 혹은 unisex인지 여부를 포함하고 있습니다.

각 상품의 이미지는 크림에서 가져와 사용하고 있습니다.

브랜드는 총 69개로 구성되어있습니다.

#### 유저 데이터 제작

##### 어떻게 하면 진짜 비지니스에서 사용 가능한 그럴듯한 유저데이터를 만들 수 있을까?

개인화 추천을 적용하기에 저는 개인적인 목표로 실제 비지니스에 적용이 가능한 추천을 만들기 위해 고민했습니다.

그런 추천을 만들기 위해서는 정확한 유저 데이터를 통해 알고리즘을 검증해야만 실제 추천의 이유가 합당하고 생각이들 것이란 결론에 이르렀습니다. 그렇기에 비록 현재 가진 자원의 한계가 있지만, 가진 자원 내에서 정확한 자료를 생성하기 위해 노력했습니다.

아래의 논문을 참고해 실제 온라인 쇼핑몰 유저 방문 타입과 타입 별 방문 비율을 설정했습니다.

- Directed Buying - 몇개의 특별한 상품들만 보고 구매를 실제로 원하는 사람
- Hedonic Browsing - 낮은 구매확률을 가지고 있고 다양한 종류의 브랜드와 카테고리를 보는 사람
- Search / Delibration - 다른 제품들을 카테고리별로 검색해보는 사람들
- Promotion Finder - 특정 할인, 광고를 통해 유입된 사람들

약 55만명의 행동 데이터를 분석해본 결과
6만 5천명의 이용자는 Promotion Finder 경향(좁은 범위의 특정 카테고리만 검색)(11%),

15만명은 Hedonic Browsing(전체의 방문의 평균보다 높은 브랜드와 제품 카테고리의 다양도, 하지만 구체적인 검색은 적음)(27%),

12만명은 Search/Delibration(제품 카테고리만 정해지고 다양한 브랜드 탐색)(21%),

나머지 20만명은 Direct Buying( 일반적으로 제품을 브랜드, 카테고리를 적은 범위에서 검색)(36%)

프로젝트 상 프로모션은 존재하지 않기 때문에 특성이 비슷한 Search/Delibration 타입으로 포함시켜 Hedonic Browsing 30%, Search/Delibration 30%, Direct Buying 40% 비율로 작성시키기로 결정했습니다.

또 유저별 유사도를 결정할 때에 현재 사용한 유사도는 코사인 유사도를 사용했습니다.

유저 데이터를 binary로 구성할 때에는 지카드 유사도를 사용해도 괜찮지만, 현재는 유저별 상품 정보를 연속적인 숫자들로 저장하고 있기에 코사인 유사도를 선택하였습니다.

### 개인화 된 추천

Python을 라이브러리인 Pandas, Numpy, sklearn을 이용해 CF 알고리즘과 CBF알고리즘을 섞어 구현한 추천 모델입니다. 한 시간 마다 각 유저별 상품 선택이 높은 것을 상위 10개의 품목을 골라 저장하는 기능을 수행합니다.

최적의 RMSE 고려해 CF 알고리즘의 최적의 이웃, 신뢰도를 고려해 모델을 설정했습니다. CBF는 물건간의 유사도를 통해 Cold user에 추천과 CF 알고리즘과 함께 사용하는 방법을 통해 하이브리드 모델을 구성했습니다. 하이브리드 알고리즘을 사용한 이유는 알고리즘끼리 서로 상호 보완 할 수 있기 때문에 적용했습니다.

현재는 MF 모델을 sgd 알고리즘을 사용해서 검증해 보고 있습니다. 추천화 결과가 어느정도 설명이 가능한 정도로 이해가 되고 만들어 진다면 추가할 계획입니다.

[CF 알고리즘 코드]()

[CBF 알고리즘 코드]()

[MF 알고리즘 (미완성)]()

각 알고리즘 별 최적화 관련된 이슈는 다음 링크에 더욱 자세히 남겨두었습니다.

## 그외 고민들

프로젝트를 진행하면 할 수록 성능과 유지보수에 대한 고민이 깊어졌습니다. 특히 변수명과 클린 코드에 대한 제가 했던 고민을 간략하게 서술하려 합니다.

코드 관련 고민

- 함수는 최대 20줄 이내, 클래스는 200줄 이내로 작성
- 함수는 한 블록안에 하나의 동작만 수행해야 한다.

변수명

- DTO
- controller function
- model columns

성능 측정 및 오류 검출은 Jmeter를 이용하여 동시성 문제, 성능관련 이슈를 측정 및 해결했습니다.