//
//  CustomSplashModelData.swift
//  CustomSplash
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI

import AppFoundation
import Domain

@Observable
final class CustomSplashModelData {
  var isAppFirstRun: Bool = false
  
  init(onComplete: @escaping (Bool) -> Void, localStorageUsecasable: LocalStorageUsecasable) {
    Task { @MainActor [weak self] in
      guard let self else { return }
      if let isAppFirstRun: Bool = await localStorageUsecasable.get(forKey: LocalStorageKey.isAppFirst.rawValue) {
        self.isAppFirstRun = isAppFirstRun
      } else {
        await localStorageUsecasable.set(false, forKey: LocalStorageKey.isAppFirst.rawValue)
      }
      onComplete(await Self.resolveLaunchLoginState(localStorageUsecasable: localStorageUsecasable))
    }
    
  }
  
  static func resolveLaunchLoginState(localStorageUsecasable: LocalStorageUsecasable) async -> Bool {
    let storedToken = await localStorageUsecasable.getModel(
      forKey: LocalStorageKey.signInTokenInfo.rawValue,
      as: UserAccessToken.self
    )
    
    guard let storedToken, !storedToken.isExpired else {
      await localStorageUsecasable.remove(forKey: LocalStorageKey.signInTokenInfo.rawValue)
      await localStorageUsecasable.remove(forKey: LocalStorageKey.signInUserInfo.rawValue)
      return false
    }
    
    return true
  }
}

