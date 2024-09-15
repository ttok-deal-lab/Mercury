//
//  Project.swift
//  AnalysisManifests
//
//  Created by 송하민 on 8/30/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: "DomainRouter",
  platform: .iOS,
  frameworkDependencies: [
    .domain,
    .domainInterface,
    .composableArchitecture
  ],
  frameworkTestDependencies: [
    
  ]
)
