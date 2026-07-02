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
  
  static func frameworkConfigure(configurations: [ConfigScheme] = ConfigScheme.allCases) -> [Configuration] {
    return configurations.map { $0.rawValue }.map { configName -> Configuration in
      if configName == .release {
        return .release(
          name: configName,
          xcconfig: .xcconfigPath("Module")
        )
      }
      return .debug(
        name: configName,
        xcconfig: .xcconfigPath("Module")
      )
    }
  }
  
  static func mainAppConfigure(configurations: [ConfigScheme] = ConfigScheme.allCases) -> [Configuration] {
    return configurations.map { $0.rawValue }.map { configName -> Configuration in
      if configName == .release {
        return .release(
          name: configName,
          xcconfig: .xcconfigPath(configName.rawValue)
        )
      }
      return .debug(
        name: configName,
        xcconfig: .xcconfigPath(configName.rawValue)
      )
    }
  }
  
}
