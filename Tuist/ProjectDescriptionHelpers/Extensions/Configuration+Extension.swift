//
//  Configuration+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension Configuration {
  
  enum ConfigScheme: ConfigurationName, CaseIterable {
    case debug = "Debug"
    case stage = "Stage"
    case release = "Release"
  }
  
  static func configure(configurations: [ConfigScheme] = ConfigScheme.allCases, isOwn: Bool = false) -> [Configuration] {
    return configurations.map { $0.rawValue }.map { configName -> Configuration in
      if configName == .release {
        return .release(
          name: configName,
          xcconfig: isOwn ? .xcconfigPath(configName.rawValue) : .xcconfigPath("Module")
        )
      }
      return .debug(
        name: configName,
        xcconfig: isOwn ? .xcconfigPath(configName.rawValue) : .xcconfigPath("Module")
      )
    }
  }
  
}
