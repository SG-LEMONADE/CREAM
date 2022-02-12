<h1 align='center'>CREAM</h1>

## Index

- 프로젝트 소개

- 기능 소개

- 설계 및 구현, 폴더 구조

- 트러블 슈팅 기록과정

<br />

---

<br />

## 프로젝트 소개

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153585949-36556ba4-a316-4ff9-a7b8-77b8963d6639.png" width='30%' ></p>

- 한정판 거래 플랫폼.

- 주식처럼 시세를 보여주며 유저간 익명으로 거래하는 플랫폼

- 경매 형식의 가격 책정 방식으로 가격이 항상 변동.

- SNS 기능이 포함되어 소셜 미디어 기능까지 지원.

> 위와 같은 기능이 있는 KREAM 서비스를 클론.

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153587734-825016de-98fb-409d-8e4a-564659505af0.png" width='80%' /></p>

- 경매 형식, 그리고 시세를 보여주는 기능에 집중.

- 기존 KREAM과 달리 사용자의 행동 패턴을 분석하여 개인화 추천 시스템을 구축함.

<br />

---

<br />

## 기능 소개

<br />

### 홈 화면

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153613713-58fe7972-b8ce-4304-9657-dd9ba0197b5f.gif" /></p>

- 기본적인 홈 화면 구현.

- slider 배너 광고가 존재하며, 각 테마별로 제품을 보여줌.

- 더 보기 버튼을 눌러 관련 상품을 더 제시 가능.

- 반응형을 고려하여 상단 광고 이미지 둥글게 변형.

<br />

#### 찜 기능

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153614684-6b94a7f8-ba34-4ae0-9fd1-c46d5013db0d.gif" /></p>

<br />

- 미 로그인 시 찜 기능 비활성화

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153616390-7cc8af6f-0f62-480a-b9cc-5f3e38072726.gif" /></p>

- 로그인 상태라면 해당 제품을 찜 할 수 있음.

- 해당 제품의 사이즈가 모달로 보여지고 해당 사이즈를 눌러 찜할 수 있도록 구현.

- 제품 별 지원되는 사이즈가 모두 다르므로,

- 찜한 사이즈를 다시 눌러 토글로 해제하여 찜 취소 기능 구현.

<br />

#### 브랜드 클릭시 search 기능

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153616978-b670d860-c339-4bb6-a4ea-778736620a2c.gif"/></p>

- 홈 화면 내 브랜드 클릭시 해당 브랜드를 키워드로 검색.

<br />

### SHOP 화면

<br />

#### 기본

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153637885-a215ec02-87c8-40ad-888d-95bc315974bd.gif"/></p>

<br />

- 필터링 구현

- 카테고리, 브랜드, 가격, 성별로 필터링하여 그리드로 표현.

- 5가지 기준으로 소팅 기능.

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153640809-b1283ba8-25dd-4925-8234-4c7ccb606162.gif" /></p>

<br />

- SHOP 화면내에서도 찜 기능 활성화.

- 홈 화면에서와 같게 각 제품별 지원되는 사이즈가 다르므로 해당 사이즈들 배열을 서버로부터 받아 모달로 창을 띄움.

- 사이즈가 적힌 버튼을 토글하는 형태로 찜 / 찜 해제 구현.

<br />

<p align='center'><img src="" /></p>

- 인피니트 스크롤 기능 추가예정

<br />

### 제품 상세 화면

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153698288-223dd1d1-c3da-4f38-9b17-9bbcdd3dc6b8.gif" /></p>

<br />

- 제품 상세 페이지 - 모든 사이즈 별 가격으로 페이지 제공.

- 제품이 가지고 있는 기본적인 스펙 제시. (모델 이름, 출시일, 색, 기존 가격)

- 사이즈 별 찜 / 찜 해제 기능.

- 사이즈 선택시 각 사이즈 별 시세가로 가격이 적용됨.

- 하단에 선택한 제품 브랜드의 다른 제품 렌더링.

- 스크롤함에따라 상단에 작은 제품 이미지와 제품 이름, 그리고 3개 버튼으로 구성된 floater 생성.

<br />

<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
<p align='center'><img src="" /></p>
