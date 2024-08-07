//
//  Project+StaticFramework.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 8/7/24.
//

import ProjectDescription

extension Project {
  
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
}
