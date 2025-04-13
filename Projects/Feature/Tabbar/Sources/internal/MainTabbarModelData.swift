//
//  MainTabbarModelData.swift
//  Tabbar
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import AppFoundation
import Domain

final class MainTabbarModelData: ObservableObject {
  @Inject private var signInTokenInformable: SignInTokenInformable
  @Published var isUserSignIn: Bool = false
  private var store = Set<AnyCancellable>()
  
  init() {
    Task { @MainActor [weak self] in
      guard let self else { return }
      signInTokenInformable.tokenInfo
        .map { $0?.accessToken != nil }
        .removeDuplicates()
        .receive(on: RunLoop.main)
        .sink { isUserLogged in
          self.isUserSignIn = isUserLogged
        }
        .store(in: &store)
        
    }
    
  }
    
}
