//
//  AppConfigService.swift
//  Domain
//
//  Created by 최수훈 on 12/31/25.
//

public protocol AppConfigService {
  var minVersion: String { get }
  var latestVersion: String { get }
  var needsUpdate: Bool { get }
  func fetchConfig() async throws
}
