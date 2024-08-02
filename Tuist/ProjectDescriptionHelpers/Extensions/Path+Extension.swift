//
//  Path+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

extension Path {
  
  public static func xcconfigPath(_ xcconfigName: String) -> Path {
    return .relativeToRoot("XCConfigs/\(xcconfigName).xcconfig")
  }
  
  public static func entitlementPath(_ entitlementsName: String) -> Path {
    return .relativeToRoot("Entitlements/\(entitlementsName).entitlements")
  }
  
  public static func infoPlistPath(_ plistName: String) -> Path {
    return .relativeToRoot("InfoPlists/\(plistName).plist")
  }
  
  public static func scriptPath(_ scriptName: String) -> Path {
    return .relativeToRoot("Tools/\(scriptName)")
  }
  
  public static func featurePath(_ name: String) -> Path {
    return .relativeToRoot("Projects/Feature/\(name)")
  }
  
  
}
