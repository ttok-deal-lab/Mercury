//
//  Project.swift
//  DataManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.feature(
  name: "Analysis",
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .coordinator
  ],
  testDependencies: []
)
