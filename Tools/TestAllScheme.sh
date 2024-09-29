#!/bin/bash

WORKSPACE="Mercury.xcworkspace"
DESTINATION="platform=iOS Simulator,name=iPhone 15"

# 워크스페이스의 모든 스킴 목록 가져오기
SCHEMES=$(xcodebuild -workspace Mercury.xcworkspace -list | awk '/Schemes:/,/^$/ {if (NR>1 && $0!="") print}' | grep -v "Schemes:" | sed 's/^[ \t]*//' | grep -v "_" | grep -v "-" | grep -v "SampleApp$")

for SCHEME in $SCHEMES
do
  echo "Testing $SCHEME"
  xcodebuild test -workspace "$WORKSPACE" -scheme "$SCHEME" -destination "$DESTINATION"
  
  if [ $? -ne 0 ]; then
    echo "Testing failed for $SCHEME"
    exit 1
  fi
done

echo "All tests completed successfully"