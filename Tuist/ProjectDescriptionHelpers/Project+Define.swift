//
//  ProjectDefine.swift
//  MercuryManifests
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension Project {
  
  
  // MARK: - project manifests
  
  static let appName: String = "Mercury"
  
  static let productName: String = "AuctionGod" // CFBundleDisplayName에서 변경
  
  static let deployTarget: DeploymentTargets = .iOS("16.0")
  
  static let bundleId = "com.auction.mercury"
  
  static let deploymentTarget: DeploymentTargets = .iOS("16.0")
  
  
  // MARK: - read file path
  
  static let commonEntitlement: Entitlements = .file(path: Path.entitlementPath("App"))
  
  
  
  
}
