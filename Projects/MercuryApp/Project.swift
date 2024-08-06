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
    .domainInterface,
    .uiComponent,
    .analysis,
    .appleSignIn,
    .googleSignIn,
    .auction,
    .comment,
    .mainTabbar,
    .profile
  ],
  testDependencies: []
)
