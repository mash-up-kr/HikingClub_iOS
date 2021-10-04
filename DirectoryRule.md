## 기본 규칙

- 그룹은 파일보다 위에 위치해야함

<img src="https://user-images.githubusercontent.com/39300449/135803020-f991bd30-1abc-4a65-a564-15e1563107e3.png"/>

- 변화가 적은 파일 순으로 위쪽에 위치
    - (위쪽) → (아래쪽)
    - xx.stoaryboard, xxViewController, xxViewModel

## 세부 규칙

- Extension: Extension 파일들을 모아두는 그룹
- Network : Network에 관련된 모든 파일들을 모아두는 그룹
- Feature : 앱을 구성하는 각 기능을 모아두는 그룹
    - 각 기능은 아래와 같은 그룹/파일을 가질 수 있음,
    view(그룹, 옵셔널), storyboard(옵셔널), viewController, viewModel
    - 예시) Home :
        - View(그룹) : Home에서만 사용되는 View(xib)를 모아두는 그룹
        - Home.storyBoard
        - HomeViewController
        - HomeViewModel
    - 예시) WebView :
        - WebViewController
        - WebViewModel
- SupportingFiles : info.plist, Resource, launchScreen 등 기타 파일들을 모아두는 그룹
    - Resource : Asset, Color, (Lottie) set을 모아두는 그룹
