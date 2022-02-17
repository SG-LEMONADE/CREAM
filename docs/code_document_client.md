<h1 align='center'>CREAM</h1>

## Index

- 기능 소개

- 설계 및 구현, 폴더 구조, 주요 기능 코드

- 트러블 슈팅 기록과정

<br />

## 기능 소개

<br />

### 홈 화면

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701586-5d3f7ba7-fd9b-407e-ad2d-3a8b4c051cef.gif" width='80%' /></p>

- 기본적인 홈 화면 구현.

- slider 배너 광고가 존재하며, 각 테마별로 제품을 보여줌.

- 더 보기 버튼을 눌러 관련 상품을 더 제시 가능.

- 반응형을 고려하여 상단 광고 이미지 둥글게 변형.

<br />

#### 찜 기능

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701382-fe1dfc8d-c2f8-4ae4-bfea-de6b579e05a0.gif" width='80%' /></p>

<br />

- 미 로그인 시 찜 기능 비활성화

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701283-7cf440b8-9c55-4d09-b25a-8a9922a5f0ac.gif" width='80%' /></p>

- 로그인 상태라면 해당 제품을 찜 할 수 있음.

- 해당 제품의 사이즈가 모달로 보여지고 해당 사이즈를 눌러 찜할 수 있도록 구현.

- 제품 별 지원되는 사이즈가 모두 다르므로,

- 찜한 사이즈를 다시 눌러 토글로 해제하여 찜 취소 기능 구현.

<br />

#### 브랜드 클릭시 search 기능

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153702462-b6dab30d-ce53-41a7-91b3-b78711fcca99.gif" width='80%' /></p>

- 홈 화면 내 브랜드 클릭시 해당 브랜드를 키워드로 검색.

<br />

### SHOP 화면

<br />

#### 기본

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153701772-b6a2f882-ac55-438e-bc45-0ea085da5760.gif" width='80%'/></p>

<br />

- 필터링 구현

- 카테고리, 브랜드, 가격, 성별로 필터링하여 그리드로 표현.

- 5가지 기준으로 소팅 기능.

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153702417-7b290c13-f704-4ed5-ac1b-e4a9dbf9d3f1.gif" width='80%' /></p>

<br />

- SHOP 화면내에서도 찜 기능 활성화.

- 홈 화면에서와 같게 각 제품별 지원되는 사이즈가 다르므로 해당 사이즈들 배열을 서버로부터 받아 모달로 창을 띄움.

- 사이즈가 적힌 버튼을 토글하는 형태로 찜 / 찜 해제 구현.

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/154393305-ee46a9e3-cd52-4ee8-b74c-c67d01d7eaae.gif" width='80%'/></p>

<br />

- 인피니티 스크롤 기능 구현.

- useSWRInfinite 를 통해 구현.

- 화면 하단에 도착시 skeleton을 통해 로딩중임을 알려줌.

- 데이터가 더이상 존재하지 않을때는 안내 문구 렌더링.

<br />

### 제품 상세 화면

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153703046-2a5b541a-791c-45ed-8254-212f0a92cd75.gif" width='80%' /></p>

<br />

- 제품 상세 페이지 - 모든 사이즈 별 가격으로 페이지 제공.

- 제품이 가지고 있는 기본적인 스펙 제시. (모델 이름, 출시일, 색, 기존 가격)

- 사이즈 별 찜 / 찜 해제 기능.

- 사이즈 선택시 각 사이즈 별 시세가로 가격이 적용됨.

- 하단에 선택한 제품 브랜드의 다른 제품 렌더링.

- 스크롤함에따라 상단에 작은 제품 이미지와 제품 이름, 그리고 3개 버튼으로 구성된 floater 생성.

<br />

#### 사이즈 선택 화면

<br />

<p align='center'><img src="https://i.imgur.com/FxQKzuJ.gif" width='80%'/></p>

<br />

- 해당 제품이 가지고 있는 사이즈들을 그리드로 표현.

- 사용자가 원하는 사이즈를 선택하여 구매 진행.

<br />

#### 구매 입찰, 판매 입찰

<br />

<p align='center'><img src="https://i.imgur.com/7hnoQGm.gif" width='80%'/></p>

<p align='center'><img src="https://i.imgur.com/glTkA6w.gif" width='80%'/></p>


<br />

- 입찰 기능 구현.

- 사이즈 그리드 선택 화면에서 넘어가는 화면.

- 구매 입찰일때

  - **즉시 구매가보다 사용자가 입력한 구매 입찰 가격이 더 높다면 즉시 구매로 자동 변경.**
  
  - 이유) 사용자의 구매 입찰 행동은 즉시 구매가보다 더 낮은 가격으로 구매하여 더 싼값에 구매하고 싶어하는 것이므로 해당 로직 추가.

- 판매 입찰일때

  - **즉시 판매가보다 사용자가 입력한 판매 입찰 가격이 더 낮다면 즉시 판매로 자동 변경.**

  - 이유) 사용자의 판매 입찰 행동은 즉시 판매가보다 더 높은 가격으로 판매하여 이득을 취하고 싶기 때문이므로 해당 로직 추가.


- 사용자가 input하는 가격을 기반으로 거래 완료.

  - validate 날짜를 지정하여 거래 완료 진행.

<br />

### 즉시 구매, 즉시 판매

<br />

<p align='center'><img src="https://i.imgur.com/SmrSvh1.gif" width='80%'/></p>

<br />

- 본인이 입찰 등록한 물품은 거래할 수 없음.

- 그 외 제품들 (타인이 입찰 등록한 거래)은 즉시 구매 및 즉시 판매가 가능함.

<br />

### 마이 프로필

<br />

#### 기본

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153699896-25264afc-3821-4c3f-9815-ab7a0c509681.gif" width='80%' /></p>

<br />

- 내 기본 정보, 구매 내역, 판매 내역, 관심상품을 한눈에 볼수 있게 구성.

- 좌측 사이드바에 메뉴를 통해 상세 내역 확인 가능.

<br />

#### 구매 내역, 판매 내역, 관심 목록 상세

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153699872-3dc98905-c950-4814-8b2a-4d280d565b04.gif" width='80%' /></p>

<br />

- 구매 / 판매 내역 상세 페이지 내부 - 입찰 대기중 / 진행 중 / 완료 별 필터링 기능

- 찜 목록 확인 가능, 삭제 기능 구현.

<br />

#### 내 정보 수정

<br />

<p align='center'><img src="https://user-images.githubusercontent.com/52649378/153699397-2f048dce-bfa9-4039-b7bc-88acec8c7de9.gif" width='80%' /></p>

<br />

- 내 정보 수정 페이지 구성.

- 비밀번호 및 닉네임 수정, 그리고 주소 추가 및 신발 사이즈 변경 기능 구현.

<br />

---

## 설계 및 구현, 폴더구조

### Atomic Design Pattern 적용.

- **`Atomic Design Pattern`** 을 사용하여 개발을 진행함.

  - 이유: 쇼핑몰 특성상 모든 화면 내에서 반복되는 요소가 많았기 때문에, 재사용성이 뛰어난 해당 디자인 패턴을 사용하면 효과적이라고 판단.

### 폴더 구조

<br />

```
└── src
    ├── 🗂 colors
    ├── 🗂 components
    │   ├── 🗂 atoms
    │   ├── 🗂 molecules
    │   ├── 🗂 organisms
    │   └── 🗂 templates
    ├── 🗂 lib
    ├── 🗂 pages
    │   ├── 🗂 my
    │   └── 🗂 products
    ├── 🗂 styles
    ├── 🗂 types
    │   └── 🗂 react-slideshow-image
    └── 🗂 utils
```

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

---

<br />

✅ **참고사항**

**`src/components/` 내부는 아래의 구조로 이루어져 있습니다.**

```
├── 🗂 {컴포넌트의 소속 단계} // ex) atoms, molecules, organisms, templates...
        ├── 🗂 {컴포넌트 단위} // ex) BannerImage, Button...
            ├── index.stories.tsx
            └── index.tsx
```

- 예를 들어 아래의 구조입니다.

```
├── components
│   ├── atoms
│   │   ├── Button
│   │   │   ├── index.stories.tsx
│   │   │   └── index.tsx
```

- `index.tsx` 는 상위 폴더인 `Button` **atom** 을 담당합니다.

- `index.stores.tsx` 는 같은 depth에 있는 `index.tsx`, 즉 위에선 `Button`에 대한 스토리북 코드입니다.

<br />

---

### **Atomic Design Pattern**의 핵심, 컴포넌트를 나눈 기준

<br />

**🤔 아래 기준은 개발 초기와 진행 중에 정해진 것으로, Atomic Design Pattern에서 정해진 것이 아닌, CREAM을 제작하며 정한 본인 기준입니다.**

#### Atom

- `ATOM`: 가장 하위 단계로, 전역적으로 재사용이 굉장히 빈번하며, 가시적으로도 더 이상 나눌 수 없는 컴포넌트.

  - 특징)

    - API 통신이 일어나면 아니함. - 필요하다면 callback으로 처리.

    - 독자적인 magin과 padding을 가지지 아니함.

<br />

- [Storybook - Atom](https://lemondade-storybook.netlify.app/?path=/story/atoms-bannerimage--big)에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

- 아래와 같이 20가지 atom으로 작성.

```
├── 🗂 atoms
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

#### Molecules

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
├── 🗂 molecules
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

#### Organisms

- `Organisms`: 실제 화면에 위치(layout을 계산하여)만 배치하면 사용자가 사용할 수 있는 단계의 컴포넌트.

  - 특징)

    - API 통신 가능.

    - 정말 사용자가 바로 사용할 수 있는 수준으로 작성.

<br />

- [Storybook - Organisms](https://lemondade-storybook.netlify.app/?path=/story/organisms-dropdown--default)에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

<br />

- 아래와 같이 18개의 organism으로 작성.

```
├── 🗂 organisms
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

#### Templates

- `Templates`: Organisms를 화면 상 어느 부분에 위치할 건지 결정.

  - 특징)

    - API 통신 활발.

    - Page단계에서는 styled를 지양하므로, 해당 단계에서 모두 layout 계산은 모두 하는 것으로 설계.

<br />

- [Storybook - Templates](https://lemondade-storybook.netlify.app/?path=/story/templates-hometemplate--default) 에서 직접 스토리북을 구성하여 확인 할 수 있습니다.

<br />

- 아래와 같이 5개의 template로 작성.

```
└── 🗂 templates
    ├── HomeTemplate
    ├── MyPageTemplate
    ├── NavTemplate
    ├── ProductTemplate
    └── ShopTemplate
```

<br />

#### Pages

- `Pages`: 실제 웹 URL 상 라우팅을 담당.

  - `Nextjs` 특성상 라우팅이 `Pages`로 동작하기 때문에, `src/pages/` 가 **Atomic Design Pattern**의 가장 최상위 단계를 담당합니다.

  - 특징)

    - API 통신 활발.

    - Page단계에서는 css적인 요소를 조정하지 아니함. 미리 준비된 `Template` 를 불러오며 필요한 경우 api 통신을 통해 받은 데이터를 내려줌.

<br />

- 아래와 같이 5개의 pages로 작성.

```
├── 🗂 pages
│   ├── _app.tsx          // nextjs에서 지원되는 기능으로, 가장 먼저 실행되며 공통 레이아웃을 담당.
│   ├── _document.tsx     // nextjs에서 지원되는 기능으로, _app 다음에 실행되며, 필요한 태그를 추가.
│   ├── 🗂 buy
│   │   ├── [id].tsx      // 제품을 구매하는 페이지, 아래 select는 제품을 구매하기 전 사이즈 선택 페이지.
│   │   └── 🗂 select
│   │       └── [id].tsx
│   ├── index.tsx         // 홈 화면.
│   ├── join.tsx          // 회원가입 페이지.
│   ├── login.tsx         // 로그인 페이지.
│   ├── 🗂 my
│   │   ├── buying.tsx    // 내가 구매한 구매 내역 페이지.
│   │   ├── index.tsx     // 마이 페이지.
│   │   ├── profile.tsx   // 내 프로필 수정 페이지.
│   │   ├── selling.tsx   // 내가 판매한 판매 내역 페이지.
│   │   └── wish.tsx      // 내가 찜한 목록 페이지.
│   ├── 🗂 products
│   │   └── [id].tsx      // 제품별 구매 / 판매 / 찜할 수 있는 상세 페이지.
│   ├── search.tsx        // 쇼핑몰의 대문 역할. - 그리드로 상품을 보여주는 페이지.
│   └── 🗂 sell
│       ├── [id].tsx      // 제품을 판매하는 페이지, 아래 select는 제품을 판매하기 전 사이즈 선택 페이지.
│       └── 🗂 select
│           └── [id].tsx
```

<br />

### 주요 기능 코드

<br />

> 코드 참조는 `파일` 을, 해당 컴포넌트의 생김새는 `스토리 북` 에 자세히 나와있습니다.

- 재사용성의 대표적인 예시

  - 커스터마이징 된 `input` 태그의 재활용성

    - 컴포넌트: [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/atoms/Button/index.tsx), [스토리 북](https://lemondade-storybook.netlify.app/?path=/story/atoms-input--email)

    <br/>

  - 위와 같은 커스터마이징 된 `input`을 프로젝트 전반, `input` 이 필요한 부분에 재사용.

    - 회원 가입 form → [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/organisms/JoinForm/index.tsx), [스토리 북](https://lemondade-storybook.netlify.app/?path=/story/organisms-joinform--default)

    - 로그인 form → [파일](https://github.com/SG-LEMONADE/CREAM/tree/develop/src/client/src/components/organisms/LoginForm), [스토리 북](https://lemondade-storybook.netlify.app/?path=/story/organisms-loginform--default)

    ***

  - 제품에 찜을 할때나, 사이즈를 설정할때 쓰이는 그리드 컴포넌트

    - [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/molecules/ProductSizeSelectGrid/index.tsx), [스토리 북](https://lemondade-storybook.netlify.app/?path=/story/molecules-productsizeselectgrid--shoe-price)

  - 그리드 컴포넌트를 모달 내 / 제품 구매, 판매시 재사용.

    - 제품 구매, 판매시 재사용 - [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/templates/SizeSelectTemplate/index.tsx), [스토리 북](https://lemondade-storybook.netlify.app/?path=/story/templates-sizeselecttemplate--buy)

    - 제품 상세 페이지 내부에서 사이즈 선택시 모달 내에 재사용 - [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/templates/ProductTemplate/index.tsx), [스토리 북](https://lemondade-storybook.netlify.app/?path=/story/templates-producttemplate--default)

- 유저 로그인 상태 유지

  - 화면 상단에 항상 존재하는 `HeaderTop` 컴포넌트에서 유저 정보를 확인합니다.

    - `swr` 를 통해 token 정보와 함께 요청을 보내 응답을 얻어 해당 토큰 정보가 유효한지 검사합니다.

  - 검사와 동시에 context api를 통해 전역적으로 해당 유저의 id를 저장합니다.

  - [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/organisms/HeaderTop/index.tsx)

- 찜 버튼 클릭시 서버에게 요청과 **동시에** 업데이트 된 내용을 다시 얻어와 화면에 보여주는 기능

  - `SWR`의 `mutate` 를 통해 즉각적인 업데이트 현황을 사용자에게 제공.

  - 마이 페이지 - 찜 목록 화면 내 찜 삭제 기능

    - [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/pages/my/wish.tsx)

    - 41번째 줄의 mutate를 통해 즉각 반영.

  - SHOP 화면 - 찜 토글 기능 구현.

    - [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/pages/search.tsx)

    - 102번째 줄의 mutate를 통해 즉각 반영.

---

## 트러블 슈팅

### Atomic Design Pattern의 문제점

**물론 충분한 장점이 존재한다.** 가령,

- **하위 단계의 컴포넌트**를 잘 구성하면 추후 page / template 단계에서는 레이아웃 계산 및 조합 시 **정말 빠르게** 개발이 가능하다.

  - 반복되는 모양 / 레이아웃을 **그저 가져다가 사용**하며 상위 단계에서 data를 내려주는 방식으로 재사용성을 극대화 할 수 있다.

  - **재사용성을** 항상 고려하므로 간단한 컴포넌트를 생성하더라도 두번 이상 사용되는지 확인하며 효율성이 증가할 수 있다.

- 추가적으로) Atomic design pattern과 잘 어울리는 **Storybook**을 활용하면 팀원들과 작성한 컴포넌트를 공유가 가능하다.

> **하지만 이에 못지 않게 큰 단점들도 보였다.**

- 작업 초기에 굉장히 **큰 시간**이 소요된다.

  - 아주 간단하고 작은 컴포넌트를 구성하더라도 _어떤 곳에서 재사용되는지 고려하며_ 더 넓게 사용될 수 있게 작성이 필요하다.

  - 작은 컴포넌트라도 **재사용성을 과하게 추구**하다보면 필요이상으로 하나의 컴포넌트가 *너무 많은 기능을 하는 경우*도 있다.

  - atomic design pattern의 효율성을 더욱 끌어내기 위해 storybook를 작성했는데, 이를 통해 작성해야하는 양이 **2배**가 되었다.

- `props drilling` 이 불가피하다.

  - **props drilling**이 상위 컴포넌트에서 하위로 이어지는 경우가 부지기수로 생긴다.

    - 해당 디자인 패턴이 **분리 - 조합**으로 이루어진 설계방식이다 보니, 결국 *상위에서 받는 데이터가 하위로 그대로 보내버리는 경우*가 있다.

    - 예시) `ShopTemplate` 에서 필터링 관련 지역 상태 관리 변수들을 하단으로 뿌리는 모습. [파일](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/client/src/components/templates/ShopTemplate/index.tsx)

  - **이를 해결하기 위해서...**

    - 작성하는 컴포넌트의 **단계**(atoms, molecules...)를 지정할 때 최대한 상위 단계와 가까이 data를 받게 선정하였다.

    - `useCallback` 을 적극적으로 사용하여 **리렌더링시에도 효율성**을 조금이라도 높였고,

    - 최대 depth를 **2단계**로 정하여 개발하였다.

  - 일일 개발일지에 해당 [고민사항](https://hackmd.io/EyhXbijFSoeIycNW2tKHrg#%ED%81%B0-%EA%B3%A0%EB%AF%BC%EA%B1%B0%EB%A6%AC)을 정리해두었습니다.

- 작성이 완료되어 여기저기서 _이미 사용중인_ 하위 단계 컴포넌트의 **수정이 쉽지 않다.**

  - 특히 가장 작은 단위였던 `Atom`의 수정이 불가피하다면 꽤나 조심스럽게 수정작업이 들어가야 한다.

    - 수정 후에도 해당 컴포넌트가 쓰이는 상위단계들 **모두** 기존대로 정상적인지 확인하여야 하며,

    - 수정의 목적인 새로운 기능 또한 이상 유무 없이 적용되어야 하기 때문이다.
