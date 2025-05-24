//
//  CustomSplashModelData.swift
//  CustomSplash
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI
import Combine

import AppFoundation
import Domain

@Observable
final class CustomSplashModelData {
  var isAppFirstRun: Bool = false
  private var store = Set<AnyCancellable>()
  private var signInInformation = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  init(onComplete: @escaping (Bool) -> Void, localStorageUsecasable: LocalStorageUsecasable) {
    Task { @MainActor [weak self] in
      guard let self else { return }
      if let isAppFirstRun: Bool = await localStorageUsecasable.get(forKey: .isAppFirst) {
        self.isAppFirstRun = isAppFirstRun
      } else {
        await localStorageUsecasable.set(false, forKey: .isAppFirst)
      }
      onComplete(self.signInInformation.accessToken != nil)
    }
    
  }
}


