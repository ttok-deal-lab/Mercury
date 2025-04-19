// swift-tools-version: 5.9
@preconcurrency import PackageDescription


#if TUIST
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  productTypes: [
    "KakaoMapsSDK-SPM": .framework,
    "Testing": .framework,
    "GoogleSignIn": .framework,
    "GoogleSignInSwift": .framework,
    "KakaoSDK": .framework,
    "KakaoSDKCommon": .framework,
    "KakaoSDKUser": .framework,
    "KakaoSDKAuth": .framework,
    "Lottie": .framework
  ],
  baseSettings: .settings(configurations: Configuration.configure())
)
#endif

let package = Package(
  name: "SwiftPackages",
  dependencies: [
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", exact: "2.12.0"),
    .package(url: "https://github.com/swiftlang/swift-testing.git", exact: "0.9.0"),
    .package(url: "https://github.com/google/GoogleSignIn-iOS.git", exact: "7.0.0"),
    .package(url: "https://github.com/naver/naveridlogin-sdk-ios", branch: "master"),
    .package(url: "https://github.com/kakao/kakao-ios-sdk", branch: "master"),
    .package(url: "https://github.com/airbnb/lottie-spm.git", exact: "4.5.1")
  ]
)
