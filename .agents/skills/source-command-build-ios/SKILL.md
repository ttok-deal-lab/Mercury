---
name: "source-command-build-ios"
description: "Migrated source command `build-ios`"
---

# source-command-build-ios

Use this skill when the user asks to run the migrated source command `build-ios`.

## Command Template

# build-ios

iOS 앱을 빌드하고 에러/경고를 분석한다.

## 빌드 (Tuist 방식 — 권장)

```bash
mise exec -- tuist build
```

## 특정 Feature 모듈만 빌드

각 Feature 모듈은 독립적인 SampleApp 타겟을 가지므로 전체 빌드 없이 단독 테스트할 수 있다.

```bash
xcodebuild \
  -workspace Mercury.xcworkspace \
  -scheme {모듈명}SampleApp \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  build
```

## xcodebuild 직접 사용 (scheme 지정 필요 시)

```bash
xcodebuild \
  -workspace Mercury.xcworkspace \
  -scheme Mercury \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  build
```

빌드 구성: Debug, Stage, Release (XCConfigs 디렉토리에서 관리)

## 빌드 결과 분석

### 에러 발생 시

에러 메시지를 파싱하여 아래 형식으로 출력:

```
[ERROR] {파일경로}:{라인}: {에러 메시지}
```

에러 유형별 대처:

| 에러 | 원인 | 대처 |
|------|------|------|
| `Cannot find type` / `Cannot find ... in scope` | import 누락 또는 타겟 의존성 누락 | `Project.swift` 의존성 확인, 의존성 방향 규칙 준수 확인 |
| `Value of type ... has no member` | 메서드/프로퍼티명 오타 또는 접근 제한자 문제 | `internal` vs `public` 접근 제한자 확인 |
| `Module not found` | Xcode 프로젝트와 Tuist 설정 불일치 | `mise exec -- tuist generate --no-open` 재실행 (`/tuist-gen`) |
| Linker error | 프레임워크 의존성 순환 또는 누락 | `/tuist-dep-check` 로 의존성 순환 확인 |

### 경고 요약

경고가 있으면 파일경로:라인 형태로 요약 출력한다.
