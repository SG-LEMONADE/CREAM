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

<br />

## 기능 소개

<br />

### 홈 화면

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701586-5d3f7ba7-fd9b-407e-ad2d-3a8b4c051cef.gif" /></p>

- 기본적인 홈 화면 구현.

- slider 배너 광고가 존재하며, 각 테마별로 제품을 보여줌.

- 더 보기 버튼을 눌러 관련 상품을 더 제시 가능.

- 반응형을 고려하여 상단 광고 이미지 둥글게 변형.

<br />

#### 찜 기능

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701382-fe1dfc8d-c2f8-4ae4-bfea-de6b579e05a0.gif" /></p>

<br />

- 미 로그인 시 찜 기능 비활성화

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701283-7cf440b8-9c55-4d09-b25a-8a9922a5f0ac.gif" /></p>

- 로그인 상태라면 해당 제품을 찜 할 수 있음.

- 해당 제품의 사이즈가 모달로 보여지고 해당 사이즈를 눌러 찜할 수 있도록 구현.

- 제품 별 지원되는 사이즈가 모두 다르므로,

- 찜한 사이즈를 다시 눌러 토글로 해제하여 찜 취소 기능 구현.

<br />

#### 브랜드 클릭시 search 기능

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153702462-b6dab30d-ce53-41a7-91b3-b78711fcca99.gif" /></p>

- 홈 화면 내 브랜드 클릭시 해당 브랜드를 키워드로 검색.

<br />

### SHOP 화면

<br />

#### 기본

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701772-b6a2f882-ac55-438e-bc45-0ea085da5760.gif"/></p>

<br />

- 필터링 구현

- 카테고리, 브랜드, 가격, 성별로 필터링하여 그리드로 표현.

- 5가지 기준으로 소팅 기능.

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153702417-7b290c13-f704-4ed5-ac1b-e4a9dbf9d3f1.gif" /></p>

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

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153703046-2a5b541a-791c-45ed-8254-212f0a92cd75.gif" /></p>

<br />

- 제품 상세 페이지 - 모든 사이즈 별 가격으로 페이지 제공.

- 제품이 가지고 있는 기본적인 스펙 제시. (모델 이름, 출시일, 색, 기존 가격)

- 사이즈 별 찜 / 찜 해제 기능.

- 사이즈 선택시 각 사이즈 별 시세가로 가격이 적용됨.

- 하단에 선택한 제품 브랜드의 다른 제품 렌더링.

- 스크롤함에따라 상단에 작은 제품 이미지와 제품 이름, 그리고 3개 버튼으로 구성된 floater 생성.

<br />

### 마이 프로필

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153699896-25264afc-3821-4c3f-9815-ab7a0c509681.gif" /></p>

<br />

- 내 기본 정보, 구매 내역, 판매 내역, 관심상품을 한눈에 볼수 있게 구성.

- 좌측 사이드바에 메뉴를 통해 상세 내역 확인 가능.

<br />

#### 구매 내역, 판매 내역, 관심 목록 상세

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153699872-3dc98905-c950-4814-8b2a-4d280d565b04.gif" /></p>

<br />

- 구매 / 판매 내역 상세 페이지 내부 - 입찰 대기중 / 진행 중 / 완료 별 필터링 기능

- 찜 목록 확인 가능, 삭제 기능 구현.

<br />

#### 내 정보 수정

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153699397-2f048dce-bfa9-4039-b7bc-88acec8c7de9.gif" /></p>

<br />

- 내 정보 수정 페이지 구성.

- 비밀번호 및 닉네임 수정, 그리고 주소 추가 및 신발 사이즈 변경 기능 구현.

<br />

## 설계 및 구현, 폴더구조

<br />

### Atomic Design Pattern 적용.

<br />

- **`Atomic Design Pattern`** 을 사용하여 개발을 진행함.

  - 이유: 쇼핑몰 특성상 모든 화면 내에서 반복되는 요소가 많았기 때문에, 재사용성이 뛰어난 해당 디자인 패턴을 사용하면 효과적이라고 판단.

### 폴더 구조

<br />

```
└── src
    ├── colors
    ├── components
    │   ├── atoms
    │   ├── molecules
    │   ├── organisms
    │   └── templates
    ├── lib
    ├── pages
    │   ├── my
    │   └── products
    ├── styles
    ├── types
    │   └── react-slideshow-image
    └── utils
```

> <br />

> - colors: 자주 사용되는 색상을 상수로 관리.
>
> - components: `Atomic Design Pattern` 에 주로 사용되는 것으로, 컴포넌트 별로 잘게 잘라 4개의 단위로 나누어 작성.
>
> - lib: 컴포넌트 전역적으로 사용되는 함수 폴터.
>
> - pages: Nextjs 를 사용, 각 페이지별 렌더링할 파일을 가지고 있는 폴더.
>
> - styles: global.css를 가지고 있는 폴더
>
> - types: 서버로부터 받는 응답에 대해 interface를 저정의.
>
> - utils: 하나의 컴포넌트에서만 사용되는, 비교적 간단한 함수를 모아둔 폴더.
>
> <br />

<br />

### **Atomic Design Pattern**의 핵심, 컴포넌트를 나눈 기준

<br />

- `ATOM`: 가장 하위 단계로, 전역적으로 재사용이 굉장히 빈번하며, 가시적으로도 더 이상 나눌 수 없는 컴포넌트.

  - 특징)

    - API 통신이 일어나면 아니함. - 필요하다면 callback으로 처리.

    - 독자적인 magin과 padding을 가지지 아니함.

<br />

- [Storybook - Atom](https://lemondade-storybook.netlify.app/?path=/story/atoms-bannerimage--big)에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

<br />

- 아래와 같이 20가지 atom으로 작성.

```
├── atoms
│   ├── BannerImage
│   ├── Brand
│   ├── Button
│   ├── Checkbox
│   ├── CollectionTitle
│   ├── HeaderMainItem
│   ├── HeaderTopItem
│   ├── Icon
│   ├── Input
│   ├── Knob
│   ├── Logo
│   ├── MyPageSidebarItem
│   ├── PriceThumbnail
│   ├── ProductImage
│   ├── ProductName
│   ├── ProductNameKor
│   ├── ProductSizeSelect
│   ├── QuickFilter
│   ├── ShortcutItem
│   └── TagItem
```

<br />
<br />

- `Molecules`: Atom들의 집합. 반복되는 atoms들을 모아놓거나, 서로 다른 atom들이 가깝게 모여 있어 전역적으로 자주 쓰이는 분자 단위. / 혹은 가장 작은 단위이지만 atom에 해당되기엔 가시적인 크기가 너무 큰 컴포넌트들에 해당.

  - 특징)

    - API 통신을 지양.

    - molecules를 구성할때 atom들에게 margin과 padding을 부여.

    - 모든 atom들이 molecules를 거쳐 organism을 구성하는 것은 아님.

<br />

- [Storybook - Molecules](https://lemondade-storybook.netlify.app/?path=/story/molecules-productdeliveryinfo--default)에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

<br />

- 아래와 같이 16개의 molecule로 작성.

```
├── molecules
│   ├── Delivery
│   ├── Modal
│   ├── ProductDetail
│   ├── ProductInfo
│   ├── ProductRecentPrice
│   ├── ProductSizeSelectGrid
│   ├── ProductSmallInfo
│   ├── ProductThumbnailImage
│   ├── QuickFilterBar
│   ├── SearchFilterItem
│   ├── Shortcuts
│   ├── SizeSelect
│   ├── TradeHistoryItem
│   ├── TradeSummary
│   ├── TradeTab
│   └── UserDetail
```

<br />
<br />

- `Organisms`: 실제 화면에 위치(layout을 계산하여)만 배치하면 사용자가 사용할 수 있는 단계의 컴포넌트.

  - 특징)

    - API 통신 가능.

    - 정말 사용자가 바로 사용할 수 있는 수준으로 작성.

<br />

- [Storybook - Organisms](https://lemondade-storybook.netlify.app/?path=/story/organisms-dropdown--default)에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

<br />

- 아래와 같이 18개의 organism으로 작성.

```
├── organisms
│   ├── Dropdown
│   ├── Floater
│   ├── Footer
│   ├── HeaderMain
│   ├── HeaderTop
│   ├── HomeProduct
│   ├── JoinForm
│   ├── LoginForm
│   ├── MyPageSidebar
│   ├── ProductGrid
│   ├── ProductThumbnail
│   ├── ProductWish
│   ├── SearchFilterBar
│   ├── ShopTopBox
│   ├── Slider
│   ├── TradeDetail
│   ├── TradeHistory
│   └── UserMembership
```

<br />
<br />

- `Templates`: Organisms를 화면 상 어느 부분에 위치할 건지 결정.

  - 특징)

    - API 통신 활발.

    - Page단계에서는 styled를 지양하므로, 해당 단계에서 모두 layout 계산은 모두 하는 것으로 설계.

<br />

- [Storybook - Templates](https://lemondade-storybook.netlify.app/?path=/story/templates-hometemplate--default) 에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

<br />

- 아래와 같이 5개의 template로 작성.

```
└── templates
    ├── HomeTemplate
    ├── MyPageTemplate
    ├── NavTemplate
    ├── ProductTemplate
    └── ShopTemplate
```

<p align='center'><img src="" /></p>

<br />

<br />

<p align='center'><img src="" /></p>

<br />

<br />

<p align='center'><img src="" /></p>

<br />

<br />

<p align='center'><img src="" /></p>

<br />

<br />

<p align='center'><img src="" /></p>

<br />
