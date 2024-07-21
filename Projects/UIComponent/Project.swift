//
//  Project.swift
//  MercuryAppManifests
//
//  Created by 송하민 on 7/21/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let uicoponent = Project.dynamicFramework(
  name: "UICompoennt",
  product: .framework,
  platform: .iOS,
  frameworkDependencies: [],
  frameworkTestDependencies: []
)
