//
//  Project.swift
//  DataManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "SignIn",
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .uiComponent,
    .router,
    .domain,
    .network,
    .infrastructure,
    .kakaoCommon,
    .kakaoLogin,
    .kakaoUser,
    .googleSignIn,
    .naverThirdPartyLogin,
  ],
  testDependencies: []
)
