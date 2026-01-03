//
//  RemoteConfigManager.swift
//  MercuryApp
//
//  Created by 최수훈 on 12/31/25.
//

import Observation

import Domain

import FirebaseRemoteConfig

final class RemoteConfigManager: AppConfigService {
  static let shared = RemoteConfigManager()
  
  // MARK: - private property
  private let remoteConfig = RemoteConfig.remoteConfig()
  
  public init() {
    let settings = RemoteConfigSettings()
#if DEBUG
    settings.minimumFetchInterval = 0
#else
    //
    settings.minimumFetchInterval = 60 * 24 * 7 // TODO: - 임시: 일주일
#endif
    remoteConfig.configSettings = settings
  }
  var minVersion: String = "0.0.0"
  var latestVersion: String = "0.0.0"
  
  func fetchConfig() async throws {
    try await remoteConfig.fetchAndActivate()
    
    minVersion = remoteConfig["min_version"].stringValue
    latestVersion = remoteConfig["latest_version"].stringValue
    
  }
  
  
}
