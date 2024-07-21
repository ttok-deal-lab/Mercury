// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "ComposableArchitecture": .framework
  ]
)
#endif

let package = Package(
  name: "SwiftPackages",
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "1.10.1")
  ]
)
