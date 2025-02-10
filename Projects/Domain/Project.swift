//
//  Project.swift
//  MercuryAppManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
  name: "Domain",
  platform: .iOS,
  frameworkDependencies: [
    .appFoundation,
    .googleSignIn,
    .googleSignInSwift,
    .naverThirdPartyLogin
  ],
  frameworkTestDependencies: [
    
  ]
)
