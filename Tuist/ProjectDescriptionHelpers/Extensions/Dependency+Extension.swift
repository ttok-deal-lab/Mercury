//
//  Dependency+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetDependency {
  
  
  // MARK: - swift package manager
  
  static let composableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
  static let kakaoMap: TargetDependency = .external(name: "KakaoMapsSDK-SPM")
  static let moya: TargetDependency = .external(name: "Moya")
  static let combineMoya: TargetDependency = .external(name: "CombineMoya")
  static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
  static let swiftAlgorithm: TargetDependency = .external(name: "Algorithms")
  static let swiftTesting: TargetDependency = .external(name: "Testing")
  static let googleSignIn: TargetDependency = .external(name: "GoogleSignIn")
  static let googleSignInSwift: TargetDependency = .external(name: "GoogleSignInSwift")
  
  
  // MARK: - own modules

  static let appFoundation: TargetDependency = .project(target: "AppFoundation", path: .relativeToRoot("Projects/AppFoundation"))
  static let network: TargetDependency = .project(target: "Network", path: .relativeToRoot("Projects/Network"))
  static let domain: TargetDependency = .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
  static let uiComponent: TargetDependency = .project(target: "UIComponent", path: .relativeToRoot("Projects/UIComponent"))
  static let analysis = FeatureDependency.analysis.framework
  static let auction = FeatureDependency.auction.framework
  static let comment = FeatureDependency.comment.framework
  static let profile = FeatureDependency.profile.framework
  static let map = FeatureDependency.map.framework
  
  typealias FeatureName = String
  
  private enum FeatureDependency: FeatureName {
    case analysis = "Analysis"
    case appleSignIn = "AppleSignIn"
    case auction = "Auction"
    case comment = "Comment"
    case profile = "Profile"
    case map = "Map"
    
    var framework: TargetDependency {
      makeFeature(self.rawValue)
    }
    
    private func makeFeature(_ featureName: String) -> TargetDependency {
      return .project(target: featureName, path: .relativeToRoot("Projects/Feature/\(featureName)"))
    }
    
  }
  
}
