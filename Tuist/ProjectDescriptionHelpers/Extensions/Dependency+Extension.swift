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
  
  
  // MARK: - own module

  static let Data: TargetDependency = .project(target: "Data", path: .relativeToRoot("Projects/Data"))
  static let Domain: TargetDependency = .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
  static let DomainInterface: TargetDependency = .project(target: "DomainInterface", path: .relativeToRoot("Projects/DomainInterface"))
  static let UIComponent: TargetDependency = .project(target: "UIComponent", path: .relativeToRoot("Projects/UIComponent"))
  static let Analysis = FeatureDependency.analysis.framework
  static let AppleSignIn = FeatureDependency.appleSignIn.framework
  static let GoogleSignIn = FeatureDependency.googleSignIn.framework
  static let Auction = FeatureDependency.auction.framework
  static let Comment = FeatureDependency.comment.framework
  static let MainTabbar = FeatureDependency.mainTabbar.framework
  static let Profile = FeatureDependency.profile.framework
  
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
