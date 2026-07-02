//
//  Project.swift
//  Manifests
//
//  Created by 송하민 on 12/28/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "Search",
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .router,
    .domain
  ],
  testDependencies: []
)
