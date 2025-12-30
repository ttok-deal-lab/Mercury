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

@Observable
final class MainTabModelData {
  private var accessTokenManager = MercuryContainer.shared.resolve(AccessTokenManagable.self)
  var isUserLoggedIn: Bool = false
  var isTabEnterFirst: Bool = false
  
  private var store = Set<AnyCancellable>()
  
  init(localStorageUsecase: LocalStorageUsecasable) {
    self.accessTokenManager.tokenInfoStream
      .receive(on: RunLoop.main)
      .sink { [weak self] userAccessToken in
        self?.isUserLoggedIn = userAccessToken != nil
      }
      .store(in: &store)
    
    Task { [weak self] in
      let appFirstRunkeyExist = await localStorageUsecase.isKeyExist(forKey: LocalStorageKey.isTabEnterFirst.rawValue)
      if !appFirstRunkeyExist {
        await MainActor.run { [weak self] in
          self?.isTabEnterFirst = true
        }
        await localStorageUsecase.set(false, forKey: LocalStorageKey.isTabEnterFirst.rawValue)
      }
    } 
  }
  
}
