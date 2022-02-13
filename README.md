<h1 align='center'>Lemonade 🍋</h1>


## Index
[🍋 프로젝트 소개](#🍋-프로젝트-소개)

[🍋 팀원 소개](#🍋-팀원-소개)

[🍋 화면 구성](#🍋-화면-구성)

[🍋 거래 진행 흐름과 개인화 추천](#🍋-거래-진행-흐름과-개인화-추천)

[🍋 프로젝트 관련 문서](#🍋-프로젝트-관련-문서)

[🍋 협업](#🍋-협업)

[🍋 Skill stack](#🍋-Skill-stack)

<br />

## 🍋 프로젝트 소개


<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153585949-36556ba4-a316-4ff9-a7b8-77b8963d6639.png" width='30%' ></p>

- 한정판 거래 플랫폼
- 주식처럼 시세를 보여주며 유저간 익명으로 거래하는 플랫폼
- 경매 형식의 가격 책정 방식으로 가격이 항상 변동
- SNS 기능이 포함되어 소셜 미디어 기능까지 지원
<br />

> 위와 같은 기능이 있는 KREAM 서비스를 클론



<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153587734-825016de-98fb-409d-8e4a-564659505af0.png" width='80%' /></p>

- 경매 형식, 그리고 시세를 보여주는 기능에 집중.
- 기존 KREAM과 달리 사용자의 행동 패턴을 분석하여 개인화 추천 시스템을 구축함.
<br />

## 🍋 팀원 소개

``` 
If life gives you lemons, make lemonade.
삶이 당신에게 레몬을 준다면, 그것으로 레몬에이드를 만들어라.
```

|<img src="https://github.com/Deserve82.png" width="300"/>|<img src="https://github.com/Derek-94.png" width="300"/>|<img src="https://github.com/KimWanki.png" width="300"/>| 
|:---:|:---:|:----:|
|[이강호](https://github.com/Deserve82)|[홍석기](https://github.com/Derek-94)|[김완기](https://github.com/KimWanki)|

---

## 🍋 화면 구성

- HOME

|<img src="https://user-images.githubusercontent.com/52649378/153741621-854c6a8f-d9d9-432e-8cad-3965b37b5083.png" width="600"/>|<img src="https://i.imgur.com/nsSvzYu.jpg" width="300"/>|
|:-:|:-:|
|front|mobile|

---

## 🍋 거래 진행 흐름과 개인화 추천

간략하게 **가격 정책**과 *구매 및 판매 진행 플로우*에 대해 설명드리면 다음과 같습니다.

- **판매자**가 *물건을 판매 할 때*

  1. 판매자는 **판매할 물건을 선택**하고 **사이즈**와 **판매 가격**을 설정해 **거래를 등록**합니다.
  2. 만약 등록한 물건의 가격이 **가장 저렴하다면** *상품 판매 가격으로 자동으로 등록*이 되고 구매자가 구매 할 수 있게 됩니다.
  3. 만약 등록한 물건의 가격이 **가장 저렴하지 않다면** *가장 저렴한 가격들이 우선적으로 판매가 되고 후순위로 밀리게 됩니다.* (등록 만료일이 지나면 등록한 거래가 취소됩니다.)

- **구매자**가 *물건을 구매 할 때*

  1. 구매자는 **구매할 물건을 선택**하고 **사이즈**와 **구매 가격**을 설정해 **거래를 등록**합니다.
  2. 만약 등록한 구매 입찰의 가격이 **가장 높다면** *자동으로 물건의 판매 가격으로 등록*이 되고 판매자가 물건을 바로 판매 할 수 있습니다.
  3. 만약 등록한 구매 입찰의 **가격이 다른 구매 입찰보다 가격이 낮다면** *후순위로 밀려 높은 가격이 우선적으로 구매 처리가 이루어지고 후순위로 밀리게 됩니다.* (등록 만료일이 지나면 등록한 거래가 취소됩니다.)

- **가격 변동**

  가격변동 차이는 (*두번째 직전 거래 - 바로 직전 거래의 차*)입니다. 퍼센테이지 역시 **두 거래의 차이 / 두번째 직전 거래** 입니다.

- **가격 히스토리**
  
  지난 가격 히스토리는 날짜별 가격은 당시 **마지막으로 거래가 된 금액**으로 책정되어 있습니다.

- 개인화 추천

    - 유저의 **클릭**, **찜**, **구매** 단위로 활동을 기록합니다.
    - 유저가 **홈 화면에 접속 했을 때**에 유저에게 *개인화된 상품을 추천*해 주는 방식으로 동작합니다.
    - 개인화 추천은 **Python**을 이용해 진행되고 있으며 *시간 당 1회 씩* 스케줄러를 이용해 추천 상품들을 업데이트 합니다.
<br />


## 🍋 프로젝트 관련 문서

- [Storybook](https://lemondade-storybook.netlify.app/)
- API 명세서 (swagger)
    - [User API]()
    - [Product API]()

---

## 🍋 협업

### Git Commit Convention

- AngularJS Git Commit Message Convention을 사용.
    
    ```typescript
    {type}({scope}): {subject}
    {BLANK LINE}
    {body}
    ```

- Commit 메시지에 작업 분류를 함께 작성하고, PR 시에만 Jira Issue 번호를 추가<br/>
    ex) 작업하기 위해 생성한 Issue의 번호가 **3번**일 때, PR 시는 `Commit Message(#3)` 으로 남긴다.

---

### Git Branch 전략 - Git-flow
<br />

<img src="https://i.imgur.com/PweO5kr.png" width="300">

<br/>

**develop 브랜치를 default으로 설정, Git flow 정책을 따름.**

*브랜치 명명 규칙*

```
    feature/{field}/{issue_number}
```

예시) IOS 작업, JIRA issue 번호가 3번이라면,


  - ex.) iOS 작업, JIRA issue가 3번 -> `feature/i/3`

**main 브랜치**를 릴리즈 브랜치로 설정.

---

### Gather 

리모트 환경 회의 및 스크럼 진행

<img src="https://i.imgur.com/ITfHhdJ.png"  width ="23%"/>

https://gather.town/app/DrcR0HJ9VkMMDMoU/SGS-DEVCAMP

---

### hackmd.io

스크럼 및 회고 기록

https://hackmd.io/team/sglemonade?nav=overview


---

## 🍋 Skill stack

- IOS

<img src="https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white" />

- Server

<img src="https://img.shields.io/badge/Kotlin-0095D5?&style=for-the-badge&logo=kotlin&logoColor=white" /> <img src="https://img.shields.io/badge/Spring_Boot-F2F4F9?style=for-the-badge&logo=spring-boot" /> <img src="https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white" /> <img src="https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white" /> <img src="https://img.shields.io/badge/redis-%23DD0031.svg?&style=for-the-badge&logo=redis&logoColor=white" />

- Frontend

<img src="https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white" /> <img src="https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white" /> <img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB" /> <img src="https://img.shields.io/badge/styled--components-DB7093?style=for-the-badge&logo=styled-components&logoColor=white" /> 

<img src="https://img.shields.io/badge/Yarn-2C8EBB?style=for-the-badge&logo=yarn&logoColor=white" /> <img src="https://img.shields.io/badge/SWR-000000?style=for-the-badge&logo=purescript&logoColor=white"/> <img src="https://img.shields.io/badge/AXIOS-purple?style=for-the-badge&logo=apache-pulsar&logoColor=white"/>
