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

final class MainTabModelData: ObservableObject {
  @Inject private var accessTokenManager: AccessTokenManagable
  @Published var isUserLoggedIn: Bool = false
  
  private var store = Set<AnyCancellable>()
  
  init() {
    Task { [weak self] in
      self?.accessTokenManager.tokenInfoStream
        .sink { userAccessToken in
          Task { @MainActor in
            self?.isUserLoggedIn = userAccessToken != nil
          }
        }
        .store(in: &self!.store)
    }
  }
  
}
