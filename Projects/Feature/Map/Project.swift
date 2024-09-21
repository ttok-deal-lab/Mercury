//
//  Project.swift
//  DataManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.feature(
  name: "Map",
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .composableArchitecture,
    .domain,
    .swiftAlgorithm,
    .uiComponent,
    .kakaoMap
  ],
  testDependencies: []
)
