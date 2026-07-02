#!/bin/bash

export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

# 프로젝트 루트 이동
cd "$(dirname "$0")/.."

# Pacakage.resolve 변경사항 없으면 pass
LOCK_FILE="Tuist/Package.resolved"
CACHE_FILE="Tuist/.license_checksum" # 체크섬 저장할 숨김 파일

# 1. Lock 파일이 없으면 패스 (Tuist가 아직 생성 안 했을 수도 있음)
if [ ! -f "$LOCK_FILE" ]; then
    echo "⚠️ warning: $LOCK_FILE 이 없습니다. 라이선스 갱신을 건너뜁니다."
    exit 0
fi

# 2. 현재 파일의 해시값(지문) 계산 (macOS shasum 사용)
CURRENT_HASH=$(shasum "$LOCK_FILE" | awk '{print $1}')

# 3. 이전에 저장된 해시값 읽기
OLD_HASH=""
if [ -f "$CACHE_FILE" ]; then
    OLD_HASH=$(cat "$CACHE_FILE")
fi

# 4. 비교: 지문이 같으면 즉시 종료
if [ "$CURRENT_HASH" == "$OLD_HASH" ]; then
    echo "⏩ 라이브러리 변경 사항 없음. 라이선스 갱신을 스킵합니다."
    exit 0
fi

# ==========================================================
# 👇 변경 사항이 있을 때만 아래 로직 실행
# ==========================================================

# .xcconfig에서 토큰 읽어오기
CONFIG_FILE="XCConfigs/Sensitive.xcconfig"

if [ -f "$CONFIG_FILE" ]; then
    LICENSE_TOKEN=$(grep "LICENSE_TOKEN" "$CONFIG_FILE" | cut -d '=' -f2 | tr -d '[:space:]')
else
    echo "⚠️ warning: $CONFIG_FILE 파일이 없습니다."
fi

if [ -z "$LICENSE_TOKEN" ]; then
    echo "⚠️ warning: LICENSE_TOKEN이 없습니다. 갱신 건너뜀."
    exit 0
fi

echo "🚀 라이브러리 변경 감지! 오픈소스 라이선스 갱신 시작..."

# Tuist vs SPM 환경을 일시적으로 통일하기 위해 가짜 루트 환경 생성
cp Tuist/Package.swift .
cp Tuist/Package.resolved .

# 5. 의존성 해결 (iOS 환경 간섭 제거)
unset SDKROOT
unset TOOLCHAINS

swift package resolve -q

# 6. LicensePlist 실행
license-plist --output-path Projects/Feature/Setting/Resources/Settings.bundle \
              --config-path Tuist/license_plist.yml \
              --github-token "$LICENSE_TOKEN" \

rm Package.swift Package.resolved
rm -rf .build

# 8. 성공했으면 현재 해시값을 저장해서 캐싱해서 빌드 최적화
echo "$CURRENT_HASH" > "$CACHE_FILE"

echo "✅ 라이선스 갱신 및 캐시 저장 완료!"
```