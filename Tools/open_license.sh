#!/bin/bash

# 1. 환경 설정 (Homebrew 등)
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

# 2. 프로젝트 루트로 이동
# 이 스크립트는 Xcode 빌드 시 실행되므로, 현재 위치가 Setting 프로젝트 폴더.
# ../../../Tools/update_licenses.sh 로 실행되더라도, 실행 주체의 위치를 기준으로 상위로 이동.
# 안전하게 스크립트 파일이 있는 위치($0)를 기준으로 루트를 찾거나, 그냥 상대 경로 사용.
cd ../../../

# 3. 토큰 확인 (Xcode Scheme 환경변수)
if [ -z "$LICENSE_TOKEN" ]; then
    echo "⚠️ warning: LICENSE_TOKEN이 없습니다. 라이선스 갱신을 건너뜁니다."
    exit 0
fi

echo "🚀 오픈소스 라이선스 갱신 중..."

# 4. [Workaround] 가짜 루트 환경 생성
cp Tuist/Package.swift .

# 5. 의존성 해결 (로그 최소화)
swift package resolve -q

# 6. LicensePlist 실행
# (config-path는 Tuist 폴더 안의 파일 지정)
license-plist --output-path Projects/Feature/Setting/Resources/Settings.bundle \
              --config-path Tuist/license_plist.yml \
              --github-token "$LICENSE_TOKEN"

# 7. 뒷정리
rm Package.swift Package.resolved
rm -rf .build

echo "✅ 라이선스 갱신 완료!"