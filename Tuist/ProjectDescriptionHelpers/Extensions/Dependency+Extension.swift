//
//  Dependency+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetDependency {
  
  static let composableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
  static let kakaoMap: TargetDependency = .external(name: "KakaoMapsSDK-SPM")
  static let moya: TargetDependency = .external(name: "Moya")
  static let combineMoya: TargetDependency = .external(name: "CombineMoya")
  static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
  static let swiftAlgorithm: TargetDependency = .external(name: "Algorithms")
  static let swiftTesting: TargetDependency = .external(name: "Testing")
  static let googleSignIn: TargetDependency = .external(name: "GoogleSignIn")
  static let googleSignInSwift: TargetDependency = .external(name: "GoogleSignInSwift")
  
  static let appFoundation: TargetDependency = .project(target: "AppFoundation", path: .relativeToRoot("Projects/AppFoundation"))
  static let network: TargetDependency = .project(target: "Network", path: .relativeToRoot("Projects/Network"))
  static let domain: TargetDependency = .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
  static let data: TargetDependency = .project(target: "Data", path: .relativeToRoot("Projects/Data"))
  static let uiComponent: TargetDependency = .project(target: "UIComponent", path: .relativeToRoot("Projects/UIComponent"))
  
  static func feature(target: String) -> TargetDependency {
    return .project(target: target, path: .featurePath(target))
  }
  
}
