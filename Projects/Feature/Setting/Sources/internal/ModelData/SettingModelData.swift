//
//  SettingModelData.swift
//  Setting
//
//  Created by 최수훈 on 12/31/25.
//

import Foundation

import AppFoundation
import Domain

@Observable
final class SettingModelData {
  
  // MARK: - Internal properties
  
  // MARK: - private properties
  private let settingUsecase: SettingUsecasable
  
  init(settingUsecase: SettingUsecasable) {
    self.settingUsecase = settingUsecase
  }
  
  public func signOut() async throws {
    try await settingUsecase.signOut()
  }
  
}
