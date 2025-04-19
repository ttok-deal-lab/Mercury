//
//  Project.swift
//  MercuryAppManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "UIComponent",
  infoPlist: .extendingDefault(with: [
    "UIAppFonts": .array([
      .string("Pretendard-Bold.ttf"),
      .string("Pretendard-SemiBold.ttf"),
      .string("Pretendard-Medium.ttf"),
      .string("Pretendard-Regular.ttf"),
      .string("Pretendard-Light.ttf")
    ])
  ]),
  platform: .iOS,
  dependencies: [
    .appFoundation,
    .lottie
  ],
  testDependencies: [.lottie],
  resourceSynthesizers: [
    .assets(),
    .fonts()
  ]
)
