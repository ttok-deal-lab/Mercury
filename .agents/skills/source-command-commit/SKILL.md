---
name: "source-command-commit"
description: "Migrated source command `commit`"
---

# source-command-commit

Use this skill when the user asks to run the migrated source command `commit`.

## Command Template

# commit

변경 사항을 검토하고 커밋한다. AGENTS.md의 "커밋 전" 체크리스트와 "커밋 메시지 규칙"을 준수한다.

## 작업 순서

### 1단계: 변경 파일 확인

`git status`와 `git diff`로 변경 내용을 확인한다.
staging된 파일이 없으면 변경 파일 목록을 사용자에게 보여주고 staging할 파일을 확인받는다.

### 2단계: 커밋 전 검증 (AGENTS.md "커밋 전" 체크리스트)

1. 커밋에 포함되어서는 안 될 파일이 staging되지 않았는가
   - `.env`, API 키, 개인 인증서 파일 제외
   - `*.xcuserstate`, `*.xcworkspacedata` (개인 설정) 제외
2. 각 커밋이 단일 목적을 가지는가
3. 주석 처리된 코드(dead code)가 포함되지 않았는가 (주석 규칙 #3)
4. 커밋 메시지가 변경 내용을 정확히 표현하는가

### 3단계: 커밋 타입 결정

| 타입 | 사용 시점 |
|------|-----------|
| `feat` | 새로운 기능 추가 |
| `fix` | 버그 수정 |
| `style` | 코드 의미에 영향 없는 수정 (포맷, 공백 등) |
| `refactor` | 기능 변경 없이 코드 구조 개선 |
| `test` | 테스트 코드 추가/수정 |
| `docs` | 문서 수정 |
| `build` | 빌드 관련 파일 수정 (Project.swift, Package.swift 등) |
| `chore` | 기타 자잘한 수정 |
| `ci` | CI/CD 관련 수정 |
| `WIP` | 작업 중인 변경사항 임시 커밋 |

### 4단계: 커밋 메시지 작성

```
{타입}: {변경 내용 한국어로 간결하게}
```

예시:
```
feat: AuctionDetailView 추가 및 FeatureRoute 연결
fix: AuctionHomeModelData 페이지네이션 커서 초기화 버그 수정
build: Comment Feature 모듈 Project.swift 추가
refactor: InterestView 서브뷰 분리
```

### 5단계: 사용자 확인 후 커밋 실행

```bash
git add {파일들}
git commit -m "{타입}: {메시지}"
```

## 금지 사항

- **Co-Authored-By를 포함하지 않는다** (AGENTS.md "커밋 전" #4)
- `--no-verify` 플래그 사용 금지
- `git add -A` 또는 `git add .` 사용 금지 — 파일을 개별 지정한다
