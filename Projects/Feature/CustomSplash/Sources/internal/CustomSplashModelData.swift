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

final class CustomSplashModelData: ObservableObject {
  @Published var isAppFirstRun: Bool = false
  @Inject private var signInInformation: SignInInformationReadable
  private var store = Set<AnyCancellable>()
  
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


