import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.app(
  name: "MercuryApp",
  destinations: [.iPhone],
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .networking,
    .router,
    .domain,
    .infrastructure,
    .feature(target: "CustomSplash"),
    .feature(target: "MainTab"),
    .feature(target: "Interest"),
    .feature(target: "Report"),
    .feature(target: "MyPage"),
    .feature(target: "Analysis"),
    .feature(target: "Auction"),
    .feature(target: "Comment"),
    .feature(target: "Map"),
    .feature(target: "Onboard"),
    .feature(target: "SignUp"),
    .firebaseCore,
    .firebaseDatabase,
    .firebaseMessaging,
    .firebaseCrashlytics,
    .firebaseAnalytics,
    .pulse,
    .pulseProxy,
    .pulseUI
  ],
  testDependencies: []
)
