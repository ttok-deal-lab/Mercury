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
    case release = "Release"
  }
  
  static func configure(configurations: [ConfigScheme]) -> [Configuration] {
    return configurations.map { $0.rawValue }.map { configName -> Configuration in
      guard configName != .release else { return .release(name: configName, xcconfig: .xcconfigPath(configName.rawValue))}
      return .debug(name: configName, xcconfig: .xcconfigPath(configName.rawValue))
    }
  }
  
}
