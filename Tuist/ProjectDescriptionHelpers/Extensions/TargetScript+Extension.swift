//
//  TargetScript+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetScript {
  
  enum UtilityTool {
    case swiftGen
    case swiftLint
    
    var scriptCommand: String {
      switch self {
      case .swiftGen:
        return "${PROJECT_DIR}/../../Tools/swiftgen config run --config \"${PROJECT_DIR}/../UIComponent/Resources/swiftgen.yml\""
      case .swiftLint:
        return "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../UIComponent/Resources/swiftlint.yml\""
      }
    }
  }
  
  static func prebuildScript(utility: UtilityTool, name: String) -> TargetScript {
    return .pre(script: utility.scriptCommand, name: name)
  }
  
}
