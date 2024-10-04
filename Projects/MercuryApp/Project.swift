import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  destinations: [.iPhone],
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .network,
    .kakaoMap,
    .swiftAlgorithm,
    .feature(target: "Analysis"),
    .feature(target: "Auction"),
    .feature(target: "Comment"),
    .feature(target: "Profile"),
    .feature(target: "Map"),
    .feature(target: "Tutorial")
  ],
  testDependencies: []
)
