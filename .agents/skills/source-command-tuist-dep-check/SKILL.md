---
name: "source-command-tuist-dep-check"
description: "Migrated source command `tuist-dep-check`"
---

# source-command-tuist-dep-check

Use this skill when the user asks to run the migrated source command `tuist-dep-check`.

## Command Template

# tuist-dep-check

모듈 간 의존성을 분석하여 AGENTS.md의 Dependency Rules 위반을 탐지한다.

## 작업 순서

1. 모든 모듈의 `Project.swift` 읽기
2. 각 모듈의 `dependencies` 추출
3. AGENTS.md의 허용/금지 규칙과 비교
4. 코드 레벨 import 위반 탐지
5. 위반 목록 + Mermaid 다이어그램 출력

## 분석 대상

```
Projects/MercuryApp/Project.swift
Projects/AppFoundation/Project.swift
Projects/Domain/Project.swift
Projects/Infrastructure/Project.swift
Projects/Network/Project.swift
Projects/Router/Project.swift
Projects/UIComponent/Project.swift
Projects/Feature/*/Project.swift  (모든 Feature 모듈)
```

## 의존성 규칙 (AGENTS.md Dependency Rules 기준)

### 허용되는 의존 관계

```
MercuryApp     → 모든 모듈
Feature        → Domain, Router, UIComponent, AppFoundation, Infrastructure, Networking
Infrastructure → Domain, Networking, AppFoundation
Networking     → AppFoundation
Domain         → AppFoundation, UIComponent
UIComponent    → AppFoundation
Router         → Domain
```

### 금지된 의존 관계

| 위반 유형 | 근거 |
|-----------|------|
| Feature → Feature | "Feature 모듈 간 직접 의존을 금지한다" (팀 규칙 #5) |
| Domain → Infrastructure | "Domain → Infrastructure 금지" (Dependency Rules) |
| Domain → Networking | "Domain → Networking 금지" (Dependency Rules) |
| Domain → UIKit / SwiftUI | "Domain Layer는 순수 Swift 코드로 유지" (Architecture Principles #4) |
| Infrastructure → Feature | 역방향 의존 |
| Networking → Feature | 역방향 의존 |
| Networking → Domain | 역방향 의존 |

## 코드 레벨 위반 탐지

Project.swift 의존성 외에, 실제 코드의 `import` 문도 검사한다:

### Domain 모듈 내 플랫폼 import

`Projects/Domain/` 내에서 `import SwiftUI`, `import UIKit` 검색

### Feature 내 다른 Feature import

`Projects/Feature/` 내에서 다른 Feature 모듈 이름의 import 검색
(자기 자신 모듈 제외)

### Infrastructure의 역방향 의존

`Projects/Infrastructure/` 내에서 Feature 모듈 import 검색

## 출력 형식

### 위반 목록

```
[위반] Feature/Auth → Feature/Home: Feature 간 직접 의존 금지 (팀 규칙 #5)
[위반] Domain/Sources/SomeFile.swift → import SwiftUI: Domain의 플랫폼 의존 금지 (Architecture Principles #4)
```

위반이 없으면:
```
의존성 위반 없음
```

### Mermaid 다이어그램

현재 모듈 의존성 그래프를 Mermaid로 출력한다:

```mermaid
graph TD
  MercuryApp --> Domain
  MercuryApp --> Infrastructure
  MercuryApp --> Feature_AuctionHome
  Feature_AuctionHome --> Domain
  Feature_AuctionHome --> Router
  Infrastructure --> Domain
  Infrastructure --> Networking
  Networking --> AppFoundation
```

## 위반 발견 시 수정 가이드

| 위반 | 수정 방법 |
|------|-----------|
| Feature → Feature | Router 또는 Domain을 통한 간접 통신으로 변경 |
| Domain → 플랫폼 | import 제거, Foundation만 허용 |
| 역방향 의존 | 의존 방향 반전 또는 프로토콜 추출로 분리 |
