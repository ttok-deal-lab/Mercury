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
  @Inject private var signInInformation: SignInInformationReadable
  private var store = Set<AnyCancellable>()
  
  init(onComplete: @escaping (Bool) -> Void) {
    Task { @MainActor [weak self] in
      guard let self else { return }
      onComplete(self.signInInformation.accessToken != nil)
    }
  }
}


