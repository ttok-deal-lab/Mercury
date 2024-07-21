//
//  Project+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 7/21/24.
//

import ProjectDescription

extension Project {
  
  public static func dynamicFramework(
    name: String,
    bundleId: String = bundleId,
    product: Product,
    platform: Platform,
    frameworkDependencies: [TargetDependency],
    frameworkTestDependencies: [TargetDependency]
  ) -> Project {
    
    let targets = makeDynamicFramework(
      name: name,
      bundleId: bundleId,
      platform: platform,
      scripts: [
        .prebuildScript(utility: .swiftGen, name: "Gen"),
        .prebuildScript(utility: .swiftLint, name: "Lint")
      ],
      dependencies: frameworkDependencies,
      testDependencies: frameworkTestDependencies
    )
    
    return Project(name: name, targets: targets, resourceSynthesizers: [])
  }
  
  // MARK: - framework target
  
  private static func makeDynamicFramework(
    name: String,
    destinations: Destinations = .iOS,
    bundleId: String,
    deploymentTargets: DeploymentTargets? = deployTarget,
    platform: Platform,
    scripts: [TargetScript],
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    coreDataModels: [CoreDataModel] = []
  ) -> [Target] {

    let mainTarget: Target = .target(
      name: name,
      destinations: destinations,
      product: .framework,
      bundleId: bundleId,
      deploymentTargets: deploymentTargets,
      infoPlist: .file(path: .plistPath("MercuryAppInfo")),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: scripts,
      dependencies: dependencies,
      settings: .settings(base: [:], configurations: Configuration.configure(configurations: Configuration.ConfigScheme.allCases)),
      coreDataModels: coreDataModels
    )
    
    let testTarget: Target = .target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(bundleId)Tests",
      deploymentTargets: deploymentTargets,
      sources: ["Tests/**"],
      resources: [],
      scripts: scripts,
      dependencies: testDependencies,
      settings: .settings(configurations: Configuration.configure(configurations: Configuration.ConfigScheme.allCases))
    )
    
    let sampleApp: Target = .target(
      name: "\(name)SampleApp",
      destinations: destinations,
      product: .app,
      bundleId: "\(bundleId).sampleApp",
      sources: ["SampleApp/Sources/**"],
      resources: ["SampleApp/Resources/**"],
      scripts: scripts,
      dependencies: dependencies
    )
    
    return [mainTarget, testTarget, sampleApp]
  }
}
