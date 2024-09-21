//
//  Project.swift
//  MercuryAppManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
  name: "UIComponent",
  platform: .iOS,
  frameworkDependencies: [
    .appFoundation
  ],
  frameworkTestDependencies: []
)
