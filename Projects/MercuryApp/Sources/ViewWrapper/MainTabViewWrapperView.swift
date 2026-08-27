//
//  MainTabViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import MainTab
import Domain
import Infrastructure

public struct MainTabViewWrapperView: View, MainTabViewable {
  
  let hostView: MainTabView<
    AuctionHomeViewWrapperView,
    InterestViewWrapperView,
    MyPageViewWrapperView,
    SignInViewWrapperView
  >
  
  public init() {
    hostView = MainTabView(
      localStorageUsecase: LocalStorageUsecase(repository: UserDefaultsStoreRepository())
    )
  }
  
  public var body: some View {
    hostView
  }
}
