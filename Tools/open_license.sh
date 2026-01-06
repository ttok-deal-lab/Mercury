#!/bin/bash
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

# license-plist 설치 확인
if ! which license-plist >/dev/null; then
  echo "warning: LicensePlist not installed. Run 'brew install license-plist'"
  exit 0
fi

# ------------------------------------------------------------------
# [입력] SPM 의존성 파일 위치 (루트 기준 ./Tuist)
PACKAGE_PATH="./Tuist"

# [출력] 결과물이 저장될 위치 (Feature/Setting 모듈 내부)
OUTPUT_PATH="./Projects/Feature/Setting/Resources/Settings.bundle"
# ------------------------------------------------------------------

echo "📍 Package Path: $PACKAGE_PATH"
echo "📍 Output Path: $OUTPUT_PATH"

# Settings.bundle 생성 실행
license-plist --output-path "$OUTPUT_PATH" --package-path "$PACKAGE_PATH"
