import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .Data,
    .Domain,
    .DomainInterface,
    .UIComponent,
    .Analysis,
    .AppleSignIn,
    .GoogleSignIn,
    .AuctionInformation,
    .Comment,
    .MainTabbar,
    .Profile
  ],
  testDependencies: []
)
