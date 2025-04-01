//
//  Dependency+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetDependency {
  static let kakaoMap: TargetDependency = .external(name: "KakaoMapsSDK-SPM")
  static let swiftTesting: TargetDependency = .external(name: "Testing")
  static let googleSignIn: TargetDependency = .external(name: "GoogleSignIn")
  static let googleSignInSwift: TargetDependency = .external(name: "GoogleSignInSwift")
  static let naverThirdPartyLogin: TargetDependency = .external(name: "NaverThirdPartyLogin")
  
  static let appFoundation: TargetDependency = .project(target: "AppFoundation", path: .relativeToRoot("Projects/AppFoundation"))
  static let network: TargetDependency = .project(target: "Network", path: .relativeToRoot("Projects/Network"))
  static let uiComponent: TargetDependency = .project(target: "UIComponent", path: .relativeToRoot("Projects/UIComponent"))
  static let router: TargetDependency = .project(target: "Router", path: .relativeToRoot("Projects/Router"))
  static let domain: TargetDependency = .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
  static let infrastructure: TargetDependency = .project(target: "Infrastructure", path: .relativeToRoot("Projects/Infrastructure"))
  
  static func feature(target: String) -> TargetDependency {
    return .project(target: target, path: .featurePath(target))
  }
  
}
