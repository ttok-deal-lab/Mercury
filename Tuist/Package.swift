// swift-tools-version: 5.9
@preconcurrency import PackageDescription


#if TUIST
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  productTypes: [
    "ComposableArchitecture": .framework,
    "KakaoMapsSDK-SPM": .framework,
    "Algorithms": .framework,
    "Moya": .framework,
    "SwiftyJSON": .framework,
    "Testing": .framework
  ],
  baseSettings: .settings(configurations: Configuration.configure())
)
#endif

let package = Package(
  name: "SwiftPackages",
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "1.12.1"),
    .package(url: "https://github.com/Moya/Moya.git", branch: "15.0.3"),
    .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", branch: "5.0.2"),
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", branch: "2.10.5"),
    .package(url: "https://github.com/apple/swift-algorithms.git", branch: "1.2.0"),
    .package(url: "https://github.com/swiftlang/swift-testing.git", branch: "0.9.0"),
    .package(url: "https://github.com/google/GoogleSignIn-iOS.git", branch: "8.0.0")
  ]
)
