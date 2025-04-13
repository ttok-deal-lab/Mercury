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
    self.isUserSignIn = signInTokenInformable.isUserLoggedIn
  }
    
}
