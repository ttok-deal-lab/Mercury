// swift-tools-version: 5.9
@preconcurrency import PackageDescription


#if TUIST
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  productTypes: [
    "KakaoMapsSDK-SPM": .staticFramework,
    "Testing": .framework,
    "KakaoSDK": .framework,
    "KakaoSDKCommon": .framework,
    "KakaoSDKUser": .framework,
    "KakaoSDKAuth": .framework,
    "Lottie": .framework,
    "Pulse": .framework,
    "PulseProxy": .framework,
    "PulseUI": .framework
  ],
  baseSettings: .settings(configurations: Configuration.frameworkConfigure())
)
#endif

let package = Package(
  name: "SwiftPackages",
  dependencies: [
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", from: "2.12.0"),
    .package(url: "https://github.com/swiftlang/swift-testing.git", from: "0.9.0"),
    .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.0.0"),
    .package(url: "https://github.com/naver/naveridlogin-sdk-ios-swift.git", from: "5.0.1"),
    .package(url: "https://github.com/kakao/kakao-ios-sdk", branch: "master"),
    .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.1"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "11.11.0")),
    .package(url: "https://github.com/kean/Pulse.git", from: "5.1.4")
    
  ]
)
