// swift-tools-version: 5.9
@preconcurrency import PackageDescription


#if TUIST
@preconcurrency import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "ComposableArchitecture": .framework,
    "KakaoMapsSDK-SPM": .staticLibrary,
    "Algorithms": .framework,
    "Moya": .framework,
    "SwiftyJSON": .framework
  ]
)
#endif

let package = Package(
  name: "SwiftPackages",
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "1.10.1"),
    .package(url: "https://github.com/Moya/Moya.git", branch: "15.0.3"),
    .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", branch: "5.0.2"),
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git", branch: "2.10.5"),
    .package(url: "https://github.com/apple/swift-algorithms.git", branch: "1.2.0")
    
  ]
)
