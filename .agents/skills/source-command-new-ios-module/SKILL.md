---
name: "source-command-new-ios-module"
description: "Migrated source command `new-ios-module`"
---

# source-command-new-ios-module

Use this skill when the user asks to run the migrated source command `new-ios-module`.

## Command Template

# new-ios-module

새 Feature 모듈 또는 Core 모듈을 프로젝트에 추가한다.

## 입력

- **모듈 타입**: `Feature` / `Infrastructure` / `Domain` / `UIComponent`
- **모듈명**: 생성할 모듈 이름 (예: Notification, Bookmark)

## 작업 절차 (AGENTS.md 작업 진행 절차 준수)

### 1단계: 분석

- 동일한 타입의 기존 모듈 `Project.swift` 읽기 (예: `Feature/AuctionHome/Project.swift`)
- 기존 모듈의 디렉토리 구조와 의존성 패턴 파악
- 새 모듈에 필요한 의존성 목록 결정

### 2단계: 구현 계획 설명

생성할 파일/디렉토리 목록과 수정이 필요한 기존 파일을 사용자에게 설명한다.

### 3단계: 사용자 확인

모듈 추가는 항상 3개 이상의 파일을 생성하므로 반드시 사용자 확인을 받는다.

### 4단계: 구현

아래 템플릿에 따라 디렉토리와 파일을 생성한다.

### 5단계: 검증

AGENTS.md "코드 작성 후" 체크리스트와 의존성 방향 규칙을 확인한다.

## Feature 모듈 Project.swift 템플릿

```swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "{모듈명}",
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .router,
    .domain
  ],
  testDependencies: []
)
```

필요하지 않은 의존성은 제거한다. Infrastructure/Networking 접근이 필요한 경우에만 추가한다.
의존성 추가 시 반드시 아래 허용 규칙을 따른다.

## 의존성 방향 규칙 (AGENTS.md 기반)

### 허용되는 의존 관계

```
Feature        → Domain, Router, UIComponent, AppFoundation, Infrastructure, Networking
Infrastructure → Domain, Networking, AppFoundation
Networking     → AppFoundation
Router         → Domain
```

### 금지된 의존 관계

```
Feature → Feature          (Feature 간 직접 의존 금지)
Domain  → Infrastructure   (역방향 의존 금지)
Domain  → Networking       (역방향 의존 금지)
Domain  → UIKit / SwiftUI  (Domain은 순수 Swift)
```

## 디렉토리 구조

### Feature 모듈

```
Projects/Feature/{모듈명}/
├── Project.swift
├── Sources/
│   ├── public/
│   │   └── {모듈명}View.swift              # 외부 노출 View
│   └── internal/
│       ├── ModelData/
│       │   └── {모듈명}ModelData.swift      # 내부 전용 (@Observable)
│       └── SubViews/                        # 서브뷰 (별도 파일로 작성)
├── Resources/
├── SampleApp/
│   ├── Sources/
│   │   └── SampleApp.swift
│   └── Resources/
└── Tests/
    └── {모듈명}Tests.swift
```

### Core 모듈 (Domain / Infrastructure 등)

```
Projects/{모듈명}/
├── Project.swift
└── Sources/
    └── {초기 파일}.swift
```

## MercuryApp 의존성 등록

`Projects/MercuryApp/Project.swift` 의 `dependencies` 배열에 추가:

```swift
// Feature 모듈인 경우
.feature(target: "{모듈명}"),

// 그 외 모듈인 경우
.target(name: "{모듈명}", condition: nil),
```

## 추가 작업

새 Feature의 화면을 네비게이션에 연결해야 하는 경우:
1. `Router` 모듈의 `FeatureRoute`에 케이스 추가
2. `MercuryApp`의 `RootViewFactory`에 해당 케이스의 View 생성 코드 추가

## 완료 후 체크리스트

- [ ] `Project.swift` 의존성이 허용 규칙을 준수하는가
- [ ] Feature → Feature 직접 의존이 없는가
- [ ] `Sources/public/`과 `Sources/internal/` 구조가 올바른가
- [ ] `MercuryApp/Project.swift` 의존성에 추가했는가
- [ ] Domain Layer에 SwiftUI/UIKit import가 없는가 (Domain 모듈인 경우)
- [ ] One Type Per File 규칙을 준수했는가
- [ ] 필요 시 `FeatureRoute` + `RootViewFactory`에 등록했는가
- [ ] `tuist generate --no-open` 실행하여 Xcode 프로젝트 업데이트
