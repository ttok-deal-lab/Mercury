//
//  MyPageModelData.swift
//  Profile
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import Combine

import AppFoundation
import Router
import Domain

@Observable
final class MyPageModelData {
  private var userInfoManager = MercuryContainer.shared.resolve(UserInfoManagable.self)
  var userInfo: UserInformation?
  
  private var store = Set<AnyCancellable>()
  
  init() {
    userInfoManager.userInfoStream.sink { [weak self] userInfo in
      Task { @MainActor [weak self] in
        self?.userInfo = userInfo
      }
    }
    .store(in: &store)
  }
}

