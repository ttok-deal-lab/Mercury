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
      settings: .settings(configurations: Configuration.configure())
    )
    
    let sampleApp = Target.target(
      name: "\(name)SampleApp",
      destinations: destinations,
      product: .app,
      bundleId: "\(Project.bundleId).\(name)SampleApp",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .file(path: Path.infoPlistPath("FrameworkSampleApp-Info")),
      sources: ["SampleApp/Sources/**"],
      resources: sampleAppResources,
      dependencies: [.target(name: name)],
      settings: .settings(configurations: Configuration.configure())
    )
    
    let tests = Target.target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(Project.bundleId).\(name)Tests",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: name)] + testDependencies,
      settings: .settings(configurations: Configuration.configure())
    )
    
    return [sources, tests, sampleApp]
  }
  
  fileprivate static func framework(
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
    
    return Project(
      name: name,
      settings: .settings(
        configurations: Configuration.configure()
      ),
      targets: targets
    )
  }
  
  
  // MARK: - method
  
  public static func staticFramework(
    name: String,
    destinations: Destinations = .iOS,
    bundleId: String = bundleId,
    product: Product = .staticFramework,
    platform: Platform,
    scripts: [TargetScript] = [],
    frameworkDependencies: [TargetDependency],
    frameworkTestDependencies: [TargetDependency]
  ) -> Project {
    return framework(
      name: name,
      destinations: destinations,
      bundleId: bundleId,
      product: product,
      platform: platform,
      scripts: scripts,
      frameworkDependencies: frameworkDependencies,
      frameworkTestDependencies: frameworkTestDependencies
    )
  }
  
  public static func dynamicFramework(
    name: String,
    destinations: Destinations = .iOS,
    bundleId: String = bundleId,
    product: Product = .framework,
    platform: Platform,
    scripts: [TargetScript] = [],
    frameworkDependencies: [TargetDependency],
    frameworkTestDependencies: [TargetDependency]
  ) -> Project {
    return framework(
      name: name,
      destinations: destinations,
      bundleId: bundleId,
      product: product,
      platform: platform,
      scripts: scripts,
      frameworkDependencies: frameworkDependencies,
      frameworkTestDependencies: frameworkTestDependencies
    )
  }
}
