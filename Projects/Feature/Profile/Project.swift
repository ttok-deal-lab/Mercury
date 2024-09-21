//
//  Project.swift
//  DataManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.feature(
  name: "Profile",
  platform: .iOS,
  dependencies: [
    .composableArchitecture,
    .uiComponent,
  ],
  testDependencies: []
)
