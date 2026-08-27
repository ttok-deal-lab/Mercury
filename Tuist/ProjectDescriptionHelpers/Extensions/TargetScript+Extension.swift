//
//  TargetScript+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetScript {
  
  enum UtilityTool {
    case swiftLint
    case localization
    case swiftGen
    case licensePlist
  }
  
  static func prebuildScript(_ utility: UtilityTool, name: String) -> TargetScript {
    return .pre(script: utility.command, name: name)
  }
  
}

private extension TargetScript.UtilityTool {
  var command: String {
    switch self {
    case .swiftLint:
      "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../UIComponent/Resources/swiftlint.yml\""
    case .localization:
      "${PROJECT_DIR}/../../Tools/generate_strings.sh"
    case .swiftGen:
      "${PROJECT_DIR}/../../Tools/swiftgen config run --config ${PROJECT_DIR}/../UIComponent/Resources/swiftgen.yml"
    case .licensePlist:
      "${PROJECT_DIR}/../../../Tools/open_license.sh"
    }
  }
}
