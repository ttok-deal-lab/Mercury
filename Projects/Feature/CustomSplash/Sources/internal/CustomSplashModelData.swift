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
  @Inject private var signInTokenInformable: SignInTokenInformable
  private var store = Set<AnyCancellable>()
  
  init(onComplete: @escaping (Bool) -> Void) {
    Task { @MainActor [weak self] in
      guard let self else { return }
      signInTokenInformable.tokenInfo
        .map { $0?.accessToken != nil }
        .sink { isUserLogged in
          onComplete(isUserLogged)
        }
        .store(in: &store)
    }
  }
}


