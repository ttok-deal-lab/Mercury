import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  destinations: [.iPhone],
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .appFoundation,
    .uiComponent,
    .network,
    .service,
    .kakaoMap,
    .swiftAlgorithm,
    .feature(target: "Analysis"),
    .feature(target: "Auction"),
    .feature(target: "Comment"),
    .feature(target: "Profile"),
    .feature(target: "Map")
  ],
  testDependencies: []
)
