---
name: "source-command-tuist-gen"
description: "Migrated source command `tuist-gen`"
---

# source-command-tuist-gen

Use this skill when the user asks to run the migrated source command `tuist-gen`.

## Command Template

# tuist-gen

Tuist로 Xcode 프로젝트를 (재)생성한다.

새 파일 추가/삭제, Asset 추가/삭제, L10n 추가/삭제 시 반드시 실행해야 한다. (AGENTS.md 팀 규칙 #9)

## 실행

```bash
mise exec -- tuist generate --no-open
```

`tuist` 를 직접 호출하지 않는다. 프롬프트 없는 셸은 PATH 에 옛 Tuist(4.118.0) 가 먼저 잡혀 외부 패키지 deployment target 이 12.0 으로 생성되고 Xcode 27 에서 빌드가 깨진다. 생성 후 `Mercury.xcworkspace/contents.xcworkspacedata` 가 `Tuist/.build/tuist-derived/Projects/` 를 참조하면 정상(4.208.0) 이다.

## 성공 시

생성된 파일 경로를 출력한다:
- `Mercury.xcworkspace`
- 각 모듈의 `.xcodeproj`

## 실패 시 — 에러 유형별 대처

### 의존성 오류 (`Cannot find target`)

1. 오류 메시지에서 누락된 타겟명 추출
2. 해당 모듈의 `Project.swift` 읽기
3. `MercuryApp/Project.swift`의 의존성 목록에 `.feature(target:)` 또는 `.target(name:)` 누락 여부 확인
4. AGENTS.md의 "허용되는 의존 관계" 규칙을 준수하며 수정

### Swift Package 오류 (`Package resolution failed`)

```bash
mise exec -- tuist install -u
mise exec -- tuist generate --no-open
```

### 설정 파일 오류 (`XCConfig not found`)

- `XCConfigs/` 디렉토리에 `Debug.xcconfig`, `Stage.xcconfig`, `Release.xcconfig` 존재 여부 확인

### Tuist 버전 불일치

```bash
mise install
mise exec -- tuist version          # .mise.toml 과 같아야 한다
mise exec -- tuist generate --no-open
```

## 관련 명령어

```bash
mise exec -- tuist build              # 빌드
mise exec -- tuist test               # 테스트
mise exec -- tuist clean && mise exec -- tuist generate --no-open  # 캐시 초기화 후 재생성
```
