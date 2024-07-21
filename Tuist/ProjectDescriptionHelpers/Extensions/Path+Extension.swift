//
//  Path+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

extension Path {
  
  public static func plistPath(_ plistName: String) -> Path {
    return .relativeToRoot("InfoPlists/\(plistName).plist")
  }
  
  public static func xcconfigPath(_ xcconfigName: String) -> Path {
    return .relativeToRoot("XCConfigs/\(xcconfigName).xcconfig")
  }
  
  public static func entitlementPath(_ entitle: String) -> Path {
    return .relativeToRoot("Projects/MercuryApp/Entitlements/\(entitle).entitlements")
  }
  
  public static func scriptPath(_ scriptName: String) -> Path {
    return .relativeToRoot("Tools/\(scriptName)")
  }
  
}
