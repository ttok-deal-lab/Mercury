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
  scripts: [
    .prebuildScript(.licensePlist, name: "Open source License")
  ],
  dependencies: [
    .uiComponent,
    .router,
    .domain
  ],
  testDependencies: [],
)

