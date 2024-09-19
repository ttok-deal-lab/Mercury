import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .appFoundation,
    .uiComponent,
    .network,
    .domain,
    .analysis,
    .auction,
    .comment,
    .profile,
    .map,
    .kakaoMap,
    .swiftAlgorithm
  ],
  testDependencies: []
)
