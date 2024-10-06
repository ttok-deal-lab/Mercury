//
//  Project.swift
//  DataManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.feature(
  name: "SignIn",
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .googleSignIn,
    .googleSignInSwift,
    .coordinator
  ],
  testDependencies: []
)
