# Mercury

이 프로젝트는 **Tuist**(4.20.0)로 관리되고 있습니다.
[설치가이드](https://docs.tuist.io/guides/quick-start/install-tuist)를 참고하세요.


### 프로젝트 구성
> Micro Feature Architecture, SwiftUI


### 코드 컨벤션 관리
> 코드 컨벤션은 SwiftLint로 관리됩니다.


 ### 커밋 로그 규칙
```
fix : 버그 수정  
feat : 새로운 기능   
build : 빌드 관련 파일 수정   
chore : 분류하기 어려운 자잘한 수정   
ci : CI 관련 수정   
docs : Documentation 수정   
style : 코드 의미에 영향을 주지 않는 수정   
refactor : 코드 리팩토링   
test : 테스트 코드 수정   
WIP : 위에 해당하지 않은 중간 변경사항
```


### 인증서 관리
> Fastlane Match를 사용하여 관리합니다.
> 
> 개발 인증서를 다운로드하여 실기기에서 어플리케이션을 실행하려면 관리자에게 디바이스 UDID를 전달하고 아래 명령어를 사용합니다.
```
fastlane match development --readonly
```


### 배포
> Github Action을 사용하여 CI, CD를 구성합니다.

