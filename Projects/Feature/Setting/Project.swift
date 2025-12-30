//
//  Project.swift
//  DataManifests
//
//  Created by 최수훈 on 12/29/25
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "Setting",
  platform: .iOS,
  dependencies: [
    .uiComponent,
    .router,
    .domain
  ],
  testDependencies: []
)
