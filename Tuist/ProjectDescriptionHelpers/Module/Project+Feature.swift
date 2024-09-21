//
//  Project+Feature.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 9/21/24.
//

import ProjectDescription

extension Project {
  
  // MARK: - private method
  
  // MARK: - method
  
  public static func feature(name: String, platform: Platform, dependencies: [TargetDependency], testDependencies: [TargetDependency]) -> Project {
    return Project
      .dynamicFramework(
        name: name,
        platform: platform,
        frameworkDependencies: dependencies,
        frameworkTestDependencies: testDependencies
      )
  }
}
