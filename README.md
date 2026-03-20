# COGO
<p align="center">
  <img src="https://img.shields.io/badge/Framework-Flutter-3cc6fd?logo=flutter" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Language-Dart-0c458b?logo=dart" alt="Dart"/>
</p>


## Technology Stack
- **Framework**: Flutter, Dart
- **아키텍처**: MVVM + get_it 서비스 로케이터
- **상태관리**: Provider
- **라우터**: GoRouter
- **http** 통신: dio
- **JSON 직렬화/역직렬**화: freezed + json_serializable
- **Communication**: STOMP WebSocket



## Diagram
```mermaid
graph TD
    MAIN["📱 main.dart"]
    ROUTES["🔀 route/routes.dart (GoRouter)"]
    FIREBASE["🔥 firebase_options.dart"]

    MAIN --> ROUTES
    MAIN --> FIREBASE
    ROUTES -->|navigates to| FEATURES

    subgraph CONSTANTS["📌 constants/"]
        C1["apis · colors · paths · constants"]
    end

    subgraph COMMON["🔧 common/"]
        C_ENUM["enums/ role · interest · application_status · login_platform"]
        C_NAV["navigator/ bottom_navigation_bar"]
        C_WIDGET["widgets/ button · textfield · dialog · date_picker · profile_card"]
    end

    subgraph DATA["🗄️ data/"]
        D_DI["di/ Dio + 401 Interceptor · GetIt DI"]
        D_DTO["dto/ Freezed DTO (request / response)"]
        D_REPO["repository/ SecureStorage"]
        D_SVC["service/ auth · chat · stomp · fcm · mentor · application · user · s3"]
    end

    subgraph DOMAIN["🏛️ domain/entity/"]
        DO["cogo · mentor · possible_date · mypage entities"]
    end

    subgraph FEATURES["🖼️ features/"]
        F_AUTH["auth/ login · signup (8단계)"]
        F_HOME["home/ 멘토목록 · 검색 · 신청 · 신고"]
        F_COGO["cogo/ 코고함 · 수락 · 거절"]
        F_CHAT["chat/ 채팅목록 · 채팅방"]
        F_MY["mypage/ 내정보 · 이미지 · 멘토설정"]
        F_SPLASH["splash/ 자동로그인 분기"]
    end

    FEATURES -->|uses| DATA
    FEATURES -->|uses| DOMAIN
    FEATURES -->|uses| COMMON
    FEATURES -->|uses| CONSTANTS
    DATA -->|calls| D_SVC
    D_SVC -->|uses| D_DI
    D_SVC -->|uses| D_DTO
    DOMAIN -->|mapped from| D_DTO
```

## 레이어 요약
```
  main.dart
   ├── constants/         ← 앱 전역 상수 (API 경로, 색상, 라우트명)
   ├── route/             ← GoRouter 라우팅 설정
   ├── common/            ← 공용 위젯(atoms→components), enum, util
   ├── data/
   │   ├── di/            ← Dio 클라이언트, GetIt 등록
   │   ├── dto/           ← Freezed DTO (request / response 도메인별 분류)
   │   ├── repository/    ← SecureStorage 로컬 저장
   │   └── service/       ← REST API, STOMP, FCM 호출
   ├── domain/entity/     ← 비즈니스 엔티티 (DTO와 분리)
   └── features/          ← 화면 + ViewModel (MVVM)
        ├── auth/          ← 로그인 / 회원가입 8단계
        ├── home/          ← 멘토 목록·검색·신청·신고
        ├── cogo/          ← 코고함 (수락/거절/매칭)
        ├── chat/          ← 채팅 목록 · 채팅방
        ├── mypage/        ← 내 정보·이미지·멘토 설정
        └── splash/        ← 자동 로그인 분기
```


## COGO Mobile Team

| 지선의 | 유진 | 윤영민 | 심상현 | 
|:--------:|:-------:| :-------:| :-------:| 
|<img width="100" src="https://avatars.githubusercontent.com/u/146940671?s=64&v=4">| <img width="100" src = "https://avatars.githubusercontent.com/u/94737714?s=64&v=4"> | <img width="100" src="https://avatars.githubusercontent.com/u/146945828?s=64&v=4"> | <img width="100" src = "https://avatars.githubusercontent.com/u/96258104?s=64&v=4">
| [sunnny619](https://github.com/sunnny619) | [HI-JIN2](https://github.com/HI-JIN2)  | [DevDAN09](https://github.com/DevDAN09) | [halfmoon-mind](https://github.com/halfmoon-mind)|
| Flutter Engineer | Flutter Engineer  | Project Manager | Outer Reviwer
