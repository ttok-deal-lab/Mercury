//
//  Project+FrameworkTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 8/7/24.
//

import ProjectDescription

extension Project {
  
  // MARK: - private method
  
  private static func frameworkTarget(
    name: String,
    destinations: Destinations,
    infoPlist: InfoPlist = .default,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements = ["Resources/**"],
    sampleAppSources: SourceFilesList = ["SampleApp/Sources/**"],
    sampleAppResources: ResourceFileElements = ["SampleApp/Resources/**"],
    product: Product
  ) -> [Target] {
    
    let sources = Target.target(
      name: name,
      destinations: destinations,
      product: product,
      bundleId: "\(Project.bundleId).\(name)",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      scripts: targetScripts,
      dependencies: frameworkDependencies,
      settings: .settings(configurations: Configuration.configure(configurations: Configuration.ConfigScheme.allCases))
    )
    
    let sampleApp = Target.target(
      name: "\(name)SampleApp",
      destinations: destinations,
      product: .app,
      bundleId: "\(Project.bundleId).SampleApp",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .file(path: Path.infoPlistPath("FrameworkSampleApp-Info")),
      sources: ["SampleApp/Sources/**"],
      resources: sampleAppResources,
      entitlements: Project.commonEntitlement,
      dependencies: [.target(name: name)],
      settings: .settings(configurations: Configuration.configure(configurations: Configuration.ConfigScheme.allCases))
    )
    
    let tests = Target.target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(Project.bundleId).Tests",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: name)] + testDependencies
    )
    
    return [sources, tests, sampleApp]
  }
  
  
  // MARK: - method
  
  static func framework(
    name: String,
    destinations: Destinations,
    bundleId: String,
    product: Product,
    platform: Platform,
    scripts: [TargetScript],
    frameworkDependencies: [TargetDependency],
    frameworkTestDependencies: [TargetDependency]
  ) -> Project {
    let targets = frameworkTarget(
      name: name,
      destinations: destinations,
      frameworkDependencies: frameworkDependencies,
      testDependencies: frameworkTestDependencies,
      targetScripts: scripts,
      product: product
    )
    
    return Project(name: name, targets: targets)
  }
}
