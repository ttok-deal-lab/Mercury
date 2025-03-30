// swift-tools-version: 5.9
@preconcurrency import PackageDescription


#if TUIST
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  productTypes: [
    "KakaoMapsSDK-SPM": .staticFramework,
    "Testing": .framework,
  ],
  baseSettings: .settings(configurations: Configuration.configure())
)
#endif

let package = Package(
  name: "SwiftPackages",
  dependencies: [
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", branch: "2.12.0"),
    .package(url: "https://github.com/swiftlang/swift-testing.git", branch: "0.9.0"),
    .package(url: "https://github.com/google/GoogleSignIn-iOS.git", branch: "7.0.0"),
    .package(url: "https://github.com/naver/naveridlogin-sdk-ios", branch: "master"),
    .package(url: "https://github.com/kakao/kakao-ios-sdk", branch: "master")
  ]
)
