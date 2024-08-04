import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .AppFoundation,
    .Data,
    .Domain,
    .DomainInterface,
    .UIComponent,
    .Analysis,
    .AppleSignIn,
    .GoogleSignIn,
    .Auction,
    .Comment,
    .MainTabbar,
    .Profile
  ],
  testDependencies: []
)
