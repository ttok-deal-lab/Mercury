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
    destinations: Destinations = .iOS,
    bundleId: String = bundleId,
    product: Product = .framework,
    platform: Platform,
    scripts: [TargetScript] = [],
    frameworkDependencies: [TargetDependency],
    frameworkTestDependencies: [TargetDependency]
  ) -> Project {
    
    let targets = makeDynamicFrameworkTargets(
      name: name,
      destinations: destinations,
      bundleId: bundleId,
      platform: platform,
      scripts: scripts,
      dependencies: frameworkDependencies,
      testDependencies: frameworkTestDependencies,
      product: .framework
    )
    
    return Project(name: name, targets: targets)
  }
  
  // MARK: - framework target
  
  private static func makeDynamicFrameworkTargets(
    name: String,
    destinations: Destinations,
    infoPlist: InfoPlist = .default,
    bundleId: String,
    deploymentTargets: DeploymentTargets? = deployTarget,
    platform: Platform,
    scripts: [TargetScript],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements = ["Resources/**"],
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    sampleAppSources: SourceFilesList = ["SampleApp/Sources/**"],
    sampleAppResources: ResourceFileElements = ["SampleApp/Resources/**"],
    product: Product
  ) -> [Target] {

    return frameworkTarget(
      name: name,
      destinations: destinations,
      infoPlist: infoPlist,
      frameworkDependencies: dependencies,
      testDependencies: testDependencies,
      targetScripts: scripts,
      sources: sources,
      resources: resources,
      sampleAppSources: sampleAppSources,
      sampleAppResources: sampleAppResources,
      product: product
    )
  }
  
  private static func frameworkTarget(
    name: String,
    destinations: Destinations,
    infoPlist: InfoPlist,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript],
    sources: SourceFilesList,
    resources: ResourceFileElements,
    sampleAppSources: SourceFilesList,
    sampleAppResources: ResourceFileElements,
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
      dependencies: [.target(name: name)]
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
}
