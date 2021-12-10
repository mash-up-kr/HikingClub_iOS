# HikingClib_iOS AssetNamingRule
## 기본 규칙

- 모든 이름은 소문자 카멜 케이스를 준수한다.
- 각각의 네이밍 컴포넌트(아래 참조)는 **언더바(_)**로 연결한다.
- 통용된 단어만 축약을 허용한다. (FAQ 등)
- 정해진 축약외에는 축약을 허용하지 않는다.
- 에셋 네임은 고유해야 한다.

![1](https://user-images.githubusercontent.com/39300449/145592460-0f304c3e-6215-4c81-94f4-c5d33a693b40.png)

- asset type : icon의 경우 **icon**, logo의 경우 **logo**, 배경의 경우 **bg,** 이미지의 경우 **img**로 정의한다.
- namespace : 아이콘이 사용되는 위치를 기입한다.
    - 공통(두개 이상의 화면에서)으로 사용되는 아이콘의 경우에는 namespace를 생략한다.
- asset name : 아이콘을 가장 잘 설명할 수 있는 메타포를 기입한다.
    - 🔍는 돋보기 이므로 search가 아닌 magnifier를 사용한다.
    - 가장 헷갈릴 수 있는 몇가지 메타포 예시
        - ">", < : AngleBracket
        - ←, → : Arrow
- qulifier : 하단 이미지 참고
    
    ![2](https://user-images.githubusercontent.com/39300449/145592474-77d12a12-0e5f-4064-b000-ae05f4c8bd1b.png)
    
- direction : 방향을 나타낼 수 있다면 기입한다. (left, right, up, down 등)
- shape : 형태를 표현해야 하는 경우 사용합니다. (circle, rectangle 등)
- outline : 아웃라인 존재 여부, 아웃라인이 존재한다면 **outline**을 명시한다.
- status : 선택, 비선택 등 아이콘이 특별한 경우에 사용된다면 기입한다.
    - normal, selected, focused 등 문법을 준수하여 기입한다.
- color : 프로젝트에서 사용하는 컬러 명시를 명시한다.(green900)
- size : 아이콘의 사이즈 명시한다.
    - 28*28처럼 width, height이 동일한 경우에는 28만 명시한다.
    - 28*40처럼 사이즈가 다른 경우 28x40으로 사이즈 전체를 명시한다.

예시)

![3](https://user-images.githubusercontent.com/39300449/145592479-04c087ef-2987-409b-be74-14fa25b281a9.png)


icon_tabbar_magnifier_left_selected_green900_28

![4](https://user-images.githubusercontent.com/39300449/145592480-dae51212-cbc9-46fd-9524-66752fdfbb6d.png)


icon_tabbar_person_selected_green900_28

![5](https://user-images.githubusercontent.com/39300449/145592482-f380781f-524a-4ef0-a70a-17ba42190af8.png)


icon_tabbar_pencil_deselected_gray200_28

![6](https://user-images.githubusercontent.com/39300449/145592485-bd705f17-4f22-429a-8e1a-370de5bf2482.png)


icon_crossX_circle_filled_black_24

![7](https://user-images.githubusercontent.com/39300449/145592487-a247dfc0-cb0a-48ec-a42b-ec39f537dda2.png)

icon_threeDots_horizon_black_24

참조 : 

[https://velog.io/@dvhuni/Xcode-Asset-Naming에-대한-견해-a2pjwn3t](https://velog.io/@dvhuni/Xcode-Asset-Naming%EC%97%90-%EB%8C%80%ED%95%9C-%EA%B2%AC%ED%95%B4-a2pjwn3t)

[https://brunch.co.kr/@pizzakim/26](https://brunch.co.kr/@pizzakim/26)
