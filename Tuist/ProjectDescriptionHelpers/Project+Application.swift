//
//  Project+Application.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

extension Project {
  
  public static func app(
    name: String,
    destinations: Destinations,
    platform: Platform,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency]
  ) -> Project {
    
    let targets = makeAppTargets(
      name: name,
      destinations: destinations,
      scripts: [
        .prebuildScript(utility: .swiftGen, name: "Gen"),
        .prebuildScript(utility: .swiftLint, name: "Lint")
      ],
      dependencies: dependencies,
      testDependencies: testDependencies
    )
    
    return Project(
      name: name,
      settings: .settings(
        configurations: Configuration.configure(isOwn: true)
      ),
      targets: targets,
      resourceSynthesizers: []
    )
  }
  
  // MARK: - Targets
  
  private static func makeAppTargets(
    name: String,
    destinations: Destinations,
    productName: String? = productName,
    bundleId: String = bundleId,
    deploymentTargets: DeploymentTargets? = deploymentTarget,
    scripts: [TargetScript],
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    coreDataModels: [CoreDataModel] = []
  ) -> [Target] {
    
    let mainTarget: Target = .target(
      name: name,
      destinations: destinations,
      product: .app,
      productName: productName,
      bundleId: bundleId,
      deploymentTargets: deploymentTargets,
      infoPlist: .file(path: .infoPlistPath("MercuryAppInfo")),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: Project.commonEntitlement,
      scripts: scripts,
      dependencies: dependencies,
      settings: .settings(
        base: [
          "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon"
        ],
        configurations: Configuration.configure(isOwn: true)
      ),
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
      dependencies: [.target(name: name)] + testDependencies,
      settings: .settings(configurations: Configuration.configure(isOwn: true))
    )
    
    return [mainTarget, testTarget]
  }
}
