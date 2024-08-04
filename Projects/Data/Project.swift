//
//  Project.swift
//  MercuryAppManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: "Data",
  platform: .iOS,
  frameworkDependencies: [
    .moya,
    .combineMoya,
    .composableArchitecture,
    .swiftyJSON
  ],
  frameworkTestDependencies: [
    
  ]
)
