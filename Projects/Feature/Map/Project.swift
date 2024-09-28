//
//  Project.swift
//  DataManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
  name: "Map",
  platform: .iOS,
  frameworkDependencies: [
    .appFoundation,
    .composableArchitecture,
    .service,
    .uiComponent,
    .kakaoMap
  ],
  frameworkTestDependencies: []
)
