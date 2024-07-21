import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: "UIComponent",
  product: .framework,
  platform: .iOS,
  frameworkDependencies: [],
  frameworkTestDependencies: []
)
