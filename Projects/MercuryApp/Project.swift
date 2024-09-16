import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .appFoundation,
    .network,
    .domain,
    .uiComponent,
    .analysis,
    .auction,
    .comment,
    .mainTabbar,
    .profile,
    .map
  ],
  testDependencies: []
)
