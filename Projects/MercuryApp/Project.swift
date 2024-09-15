import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .appFoundation,
    .data,
    .domain,
    .uiComponent,
    .analysis,
    .googleSignIn,
    .auction,
    .comment,
    .mainTabbar,
    .profile,
    .map
  ],
  testDependencies: []
)
