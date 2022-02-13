code_document_ios
===

###### 작성자 : wankikim
<br />

## 목차

- 화면 구성
- 디렉토리 구조
- 개발 과정


## 📱 화면 구성

|<img src="https://i.imgur.com/eD9rTSW.jpg" width = 300px>|<img src="https://i.imgur.com/ZGwgBHY.jpg" width = 300px>|<img src="https://i.imgur.com/oy5gqIa.png" width = 300px>|
|:--:|:--:|:--:|
|HomeScene|ProductListScene|MyPageScene</br>(usecase까지 설계 완료,</br> 화면 출력 개발 진행 중)|
|<img src="https://i.imgur.com/EyFhuex.jpg" width = 300px>|<img src="https://i.imgur.com/GMU1LXH.png" width = 300px>|<img src="https://i.imgur.com/J2L5CRs.png" width = 300px>|
|ProductScene</br>(차트 라이브러리 도입 필요)|FilterScene</br>(브랜드 관련 API 연결 필요)|SortScene|
|<img src="https://i.imgur.com/6UBNn1B.png" width = 300px>|<img src="https://i.imgur.com/1VQ0mfd.png" width = 300px>|<img src="https://i.imgur.com/x63pP8b.png" width = 300px>|
|LoginScene|JoinScene|SettingScene|
|<img src="https://i.imgur.com/9qae4IZ.png" width = 300px>|||
|TradeScene</br>(비지니스 로직 연결 필요)|||


## 📂 디렉토리 구조
<br />

```
🗂 Application                 : 앱 진입점 역할
├── 🔗 AppDelegate.swift
└── 🔗 SceneDelegate.swift
🗂 Data                        : Data Layer
├── 🗂 Network
│   └── 🗂 DataMapping
│       └── 🔗 DataMapping
└── 🗂 Repositories                - 프로토콜을 채택한 구체 클래스

🗂 Domain                      : Domain Layer  
├── 🗂 Entities
├── 🗂 Interfaces             
│   └── 🗂 Repositories            - Repository 프로토콜
└── 🗂 UseCases

🗂 Infrastructure
├── 🗂 Common
└── 🗂 Network

🗂 Presentation                : Present Layer + MVVM
├── 🗂 Base                        - 전반적으로 사용되는 Protocol, Custom UI 요소
│   ├── 🗂 Protocol            
│   └── 🗂 Views
│   └── 🔗 BaseDIViewController.swift  - 모든 VC의 부모 클래스(viewModel 주입 요구.)
│
├── 🗂 {특정 화면A}_Scene               - A 화면 단위 폴더 구성
│   └── 🗂 Views                         - 재사용할 뷰(Cell, UIView)
│   └── 🔗 A_ViewController.swift           - 뷰 Life Cycle, Layout 외 Setting
│   └── 🔗 A_View.swift                     - 뷰 Layout, Constraint 설정
│   └── 🔗 A_ViewModel.swift                - 뷰 모델
│   └── 🔗 A_View+CompoisitionalLayout.swift   - Compositional 레이아웃 구성 시 extension으로 분리       
├── 🗂 {특정 화면B}_Scene               
├── 🗂 {특정 화면C}_Scene               
├── 🗂 ...
│
🗂 SupportFile                  
🗂 Extension                    : 확장 활용해 해당 타입에서 사용할 수 있도록 함.
```

디렉토리 구조를 선정하는 과정에 있어 어떤 방식으로 일할 것인가에 대해 먼저 정의해야한다고 생각했다.
협업을 하는 프로젝트를 진행하게 될 경우, 비지니스 로직을 구성하는 역할과 화면 구성의 역할이 나눠질 수 있을 거라 생각했고, 이를 바탕으로 Layer를 기준으로 구조를 나누는 [Clean Architecture](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)에 대해 공부했다.
</br> 적용한다면 역할 별 디렉토리 이동도 줄이고, Layer 별로 나눴기에 병렬 작업이 가능할 것이라고 판단.

## 개발 과정

### 1. 뷰 구성
---
#### 0. 코드를 활용한 구현
스토리보드 사용 시 수정사항이 없이 파일만 열었다 닫는 것만으로도 변동사항이 발생할 수 있고,
 UI 변경 시, 변경된 부분에 대한 파악이 직관적으로 어렵다고 판단함.

##### 라이브러리 사용: SnapKit을 활용해서 뷰의 레이아웃 제약 구성.

사용 이유: UIKit에서 제공하는 [NSLayoutConstraint](https://developer.apple.com/documentation/uikit/nslayoutconstraint)와 [NSLayoutAnchor](https://developer.apple.com/documentation/uikit/nslayoutanchor)을 활용할 수 있지만, 이미 충분한 사용을 해봤다고 생각했고, SnapKit이 UI 구성 과정에서 반복 코드를 줄일 수 있으며, 직관적으로 상당히 편리하다는 내용을 검색 과정에서 알게 됐다.


#### 1. view layout - view controller 간 코드 분리
일부 뷰에서 `UICompositionalLayout`을 활용한 `CollectionView`를 구성하는 과정에서 `Layout`을 구성하기 위한 긴 코드가 발생했다. `ViewController`의 코드 줄 수가 600줄을 넘어섰음. 구현한 `MVVM`의 구조에서 `View`와 `ViewController` 모두 `View` 영역에 속하지만, 해당 코드를 뷰의 이벤트 및 동작을 위한 코드와 뷰의 생성을 위한 코드로 분리하는 것이 역할 분리를 통해 구조적 가독성을 높일 수 있었고, `UIView`를 상속받은 `CustomView`들을 따로 구성함에 따라 반복되는 뷰의 경우, 재사용하는 방식으로 활용이 가능했다.

#### 2. **view configuration** protocol 선언 및 채택
`view`의 구성 과정이 일관되도록 구성하고자 함.

따라서 `View`가 가져야하는 역할에 대해 `protocol`로 선언하고, 이를 활용해 일관된 방식으로 뷰를 구성했다.

#### 모든 뷰 요소는 [ViewConfiguration](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Presentation/Base/Protocol/ViewConfiguration.swift) 프로토콜을 채택하고 있다.
`View` 요소가 `ViewConfiguration` 프로토콜을 채택하여 일관된 방식으로 모든 뷰를 구성했고, `protocol`의 `extension`을 활용해 템플릿 메소드 패턴 형식으로 `applyViewSettings()`를 구성했고, 이를 호출할 경우, 필요한 메소드들이 순서에 맞게 호출되도록 했다.

```swift=
protocol ViewConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func viewConfigure()
}

extension ViewConfiguration {
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        viewConfigure()
    }
    
    func viewConfigure() { }
}
```

**🔔 뷰 구성에 있어 상속을 활용하지 않고, 프로토콜을 사용한 이유？**
UIView를 상속하여 뷰 구성을 위한 템플릿을 작성한 클래스를 선언하고, 이를 활용했을 경우, 구성하려는 뷰가 UIView를 상속받을 경우, 일관된 구성이 가능할 수 있지만, `UICollectionViewCell`, `UITableViewCell` 등을 상속 받을 경우, **일관된 방식으로 `View` 구성이 어려워질 수 있다고 판단**했다.


#### 3. Initialize

UI를 코드로 구성하기 때문에 인터페이스 빌더를 활용하는 `required init(coder:)`의 경우, 실제 호출이 이뤄지지 않기 때문에 
**`@available(*, unavailable)` 키워드를 활용해 사용되지 않음을 명시했다.**

#### 4. View Life Cycle

**모든 ViewController에서 View는 loadView 시점에 할당해주었다.**
viewController로부터 view layout을 분리했고, addSubview를 통해 인터페이스 빌더를 통해 생성된 뷰 위에 생성한 View를 올릴수도 있지만, 뷰가 생성되는 `loadView()` 시점에 view 넣어주는 것이 가장 적합한 시점이라고 판단했다. (addSubview()의 경우 동작상 문제는 없지만, 의미 없는 뷰가 한층 더 쌓임.)
또한 인터페이스 빌더를 사용하지 않아 loadView()를 오버라이딩해 직접 뷰를 할당해주도록 코드를 작성했다.

```swift=
// MARK: View Life Cycle
override func loadView() {
    self.view = view
}
```

### 2. MVVM Pattern + Architecture

![그림](https://i.imgur.com/1Ditidk.png)

[확대 링크](https://camo.githubusercontent.com/93a946e3de110e15d10876dc05296a14a777136586a965dbbbbe49612ec904e2/68747470733a2f2f692e696d6775722e636f6d2f3144697469646b2e706e67)


MVC 패턴에서 ViewController가 컨트롤러의 역할을 할때와는 달리 **MVVM 패턴을 활용할 경우**, **뷰 영역으로 분류**하게 된다. 실질적인 로직에 대해서는 ViewModel이 다루도록 하고, 모델에서의 변화가 발생했을 때, 이를 바인딩된 뷰가 뷰를 변경하는 로직을 가지게 된다.

> **MVVM**패턴을 활용해 프로젝트를 구성하되, 재사용성을 높이고, 테스트가 용이하도록 구성하고자 했다.

-> 그 과정에서 ViewModel의 의존성을 줄이겠다는 생각을 시작으로 비지니스 로직에 대해서도 의존성을 줄여보자는 생각을 하게 됐고, 클린 아키텍쳐의 일부를 적용할 수 있도록 함.

1. **역할에 따라 나눈 영역이 실제 구체 클래스에 직접 의존을 피할 수 있도록 프로토콜을 활용했다.**

    View와 ViewModel간의 의존 관계에 대해 View ViewModel에 대한 분리 과정에서 의존성을 줄이고자 하는 선택을 하고 싶었다.
</br>

2. **분리한 구조에 맞춰 의존성 주입 방식을 활용했다.**
    생성자를 통해 의존성을 주입했기 때문에 init() 의 매개변수를 통해 요구되는 의존성을 파악할 수 있도록 했다.
    따라서 viewModel을 테스트하기 위해 UseCaseInterface를 채택한 MockUseCase을 주입해 UseCase가 원하는 동작을 하도록 설정한다면 ViewModel이 독립적으로 테스트가 가능하다.
</br>   
 
3. **모든 View는 ViewModel을 가지도록 하기 위해, 제네릭을 활용한 [DIViewController.swift](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Presentation/Base/DIViewController.swift)를 선언하고, 이를 상속하도록 구성함.**


### MVVM Pattern 및 아키텍쳐 구현 과정에서 고민과 선택
---
#### Binding
View가 ViewModel의 변화를 감지하거나, ViewModel이 View의 변화를 감지하기 위해서는 바인딩(Binding)이 필수.

여러 바인딩 방법 중
1. Observable Helper class
2. Property Observer
3. Notification Center
4. Combine / RxSwift 비동기 라이브러리 사용

이 중 Observable Helper class를 선언하고, 이를 View와 바인딩하는 방법을 선택.
2,3은 반복구현이 많이 요구되고, 비동기 라이브러리를 단순 바인딩을 위해 도입할 필요는 없다고 판단했다.

### 구현 중 중점 사항

---
1. **모든 Presentation의 모든 Scene 일관된 구조를 가지도록 설계하였다.**

    ```
        View  -> ViewModelInterface ◁- ViewModel -> UseCaseInterface
                                                              △
                                                              │
    APIService <-  Repository -▷ RepositoryInterface  <-  UseCase
    ```
    
    ### Login Scene로 보는 코드 구조
    *각 링크는 해당 코드로 연결.*

    [로그인 뷰 컨트롤러](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Presentation/LoginScene/LoginViewController.swift)

    [로그인 뷰 모델 및 뷰모델 인터페이스](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Presentation/LoginScene/LoginViewModel.swift)

    [사용자 유스케이스 및 유스케이스 인터페이스](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Domain/UseCases/UserUseCase.swift)

    [사용자 리포지터리 인터페이스](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Domain/Interfaces/Repositories/UserRepositoryInterface.swift) 

    [사용자 리포지터리](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Data/Repositories/UserRepository.swift)

</br>

2. **의존성 주입 구조**

    ```swift=
    guard let baseURL = URL(string: "http://~~.~~")
    else { fatalError() }
                    
    let config: NetworkConfigurable              = ApiDataNetworkConfig(baseURL: baseURL)
    let networkService: NetworkService           = DefaultNetworkService(config: config)
    let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
    -------------------------------------------------------------------------------------------------------
    let repository: RepositoryInterface          = Repository(dataTransferService: dataTransferService)
    let usecase: UseCaseInterface                = UseCase(repository)
    let viewModel: ViewModelInterface            = ViewModel(usecase)
    let viewController: ViewController           = ViewController(viewModel)
    ```
    
    **🔧 상단 코드 변경 예정** 
    
        요청할 API에 따라 다른 서버 url을 사용하고 있어, 현재 BaseURL을 리터럴 값으로 작성한 상태.
        게이트 웨이 구성 이후, plist file에 딕셔너리 형태로 저장하고, 사용하는 방식으로 변경 예정.
        변경 후
        코드 내 구분선 윗부분에 대한 코드 반복을 줄일 수 있도록 변경 예정.
        repository, usecase, viewModel, viewController 만 주입하는 방식으로 진행.
    
<br/>

3. **Delegate Pattern을 활용하기 위한 Protocol 선언 위치**

    **`delegate`가 채택해야할 `protocol` 선언은 해당 delegate에 의존하는 `Class` 선언부 상단에 선언하였다.**
    또한, `delegate` 역할을 하는 `ViewController`의 경우, `extension`과 `MARK` 주석을 활용해 해당 `delegate`의 역할을 하고 있음을 명시하였음.
    
    해당 `ViewController`가 여러 개의 `protocol`을 채택하고 있을 경우, `UIKit` 내 프로토콜(ex. `UITableViewDataSource`,     ..), 사용자 정의 프로토콜(`MyProtocolDelegate`, ... )의 일관된 순서로 코드를 구성했다.
    
    일부 뷰의 경우, 프로토콜의 네이밍으로 역할을 명시적으로 나누기 어렵거나 단순한 기능을 위해 채택해야 할 protocol이 너무 많아진다 판단되면     필요에 따라 Closure을 이용해 뷰 간 통신을 진행했다.
</br>

4. **네트워크 통신을 위한 코드 구성**
네트워크 통신 코드 또한 Layer을 나눴다.

     데이터를 전달하는 역할: `DataTransferService` 
네트워크를 요청하는 역할: `NetworkService` 

    해당 부분의 Layer 구조 또한 [iOS-Clean-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)을 참고하며 작성했으며, 백엔드 팀원과 정한 에러 메시지를 바탕으로 에러 발생 시, repository로부터 반환받은 에러에 대해 usecase에서 분기하고, viewModel은 반환 받은 에러를 바탕으로 에러 메시지를 사용자에게 보여주도록 함.
</br>

5. **구체화된 Repository에 직접 접근하지 않고, protocol을 통한 Interface에 접근하도록 함.**
    
    실제 동일한 클래스에 의존하더라도 protocol에 따라 usecase가 접근할 수 있는 권한을 제어했다.
    실제 ProductRepository에 접근하지만, 각 Repository의 Interface Protocol을 통해 접근하기 때문에 usecase는 구체 클래스의 정보에 대해 알지 못한다.

    [ProductRepository.swift](https://github.com/SG-LEMONADE/CREAM/blob/develop/src/ios/Cream/Data/Repositories/ProductRepository.swift) 에서 구체 클래스를 구현.
    [Domain Layer 폴더 내](https://github.com/SG-LEMONADE/CREAM/tree/develop/src/ios/Cream/Domain/Interfaces/Repositories)에서 Repository의 인터페이스 구현.

    이에 대한 UML을 그리면 하단과 같이 표현할 수 있음.
    ![](https://i.imgur.com/xG0jD7i.png)
    
    [확대 링크](https://camo.githubusercontent.com/b7c38f8220e51876d95b01689a4ad8999cd0cb18045c89a873b733b8df2fde67/68747470733a2f2f692e696d6775722e636f6d2f7847306a4437692e706e67)
    


### 기술 스택 🔧
- Apple Swift version 5.5.1
- Xcode 13.1
- Third Party Library
  - Snapkit 5.0.1
  - Toast_Swift
  - SwiftKeychainWrapper
  
<br/>

### 실제 테스트한 기기 📲
- iPhone 8+ (414x736)
- iPhone 12 Pro (390x844)



