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
  
  
  
  // MARK: - own module

  static let appFoundation: TargetDependency = .project(target: "AppFoundation", path: .relativeToRoot("Projects/AppFoundation"))
  static let data: TargetDependency = .project(target: "Data", path: .relativeToRoot("Projects/Data"))
  static let domain: TargetDependency = .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
  static let domainInterface: TargetDependency = .project(target: "DomainInterface", path: .relativeToRoot("Projects/DomainInterface"))
  static let uiComponent: TargetDependency = .project(target: "UIComponent", path: .relativeToRoot("Projects/UIComponent"))
  static let analysis = FeatureDependency.analysis.framework
  static let appleSignIn = FeatureDependency.appleSignIn.framework
  static let googleSignIn = FeatureDependency.googleSignIn.framework
  static let auction = FeatureDependency.auction.framework
  static let comment = FeatureDependency.comment.framework
  static let mainTabbar = FeatureDependency.mainTabbar.framework
  static let profile = FeatureDependency.profile.framework
  
  typealias FeatureName = String
  
  private enum FeatureDependency: FeatureName {
    case analysis = "Analysis"
    case appleSignIn = "AppleSignIn"
    case googleSignIn = "GoogleSignIn"
    case auction = "Auction"
    case comment = "Comment"
    case mainTabbar = "MainTabbar"
    case profile = "Profile"
    
    var framework: TargetDependency {
      makeFeature(self.rawValue)
    }
    
    private func makeFeature(_ featureName: String) -> TargetDependency {
      return .project(target: featureName, path: .relativeToRoot("Projects/Feature/\(featureName)"))
    }
    
  }
  
}
