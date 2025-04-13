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

final class MyPageModelData: ObservableObject {
  @Inject private var userInformationStream: SignInUserInformable
  @Published var userInfo: ServiceSignInUserInfo?
  
  private var store = Set<AnyCancellable>()
  init() {
    userInformationStream.userInfo.sink { [weak self] userInfo in
      self?.userInfo = userInfo
    }
    .store(in: &store)
  }
}

