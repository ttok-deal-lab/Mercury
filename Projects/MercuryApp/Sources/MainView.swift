//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//

import SwiftUI
import Foundation
import Combine

import AppFoundation
import Router
import UIComponent
import Domain
import Infrastructure

struct MainView: View {
  @StateObject private var coordinator = NavigationCoordinator<FeatureRoute>()
  @State private var isSplashDone  = false
  @State private var isUserLoggedIn = false
  
  var body: some View {
    ZStack {
      currentView()
    }
    .shake(onPresent: {
      self.coordinator.eventSubject.send(.presentFullScreen(.networkConsole))
    })
    .animation(.easeInOut(duration: DesignDefine.transitionOpacityDuration), value: isSplashDone)
  }

  @ViewBuilder
  private func currentView() -> some View {
    if !isSplashDone {
      CustomSplashViewWrapperView(onComplete: { loggedIn in
        isSplashDone = true
        isUserLoggedIn = loggedIn
      })
    } else if !isUserLoggedIn {
      SignInViewWrapperView(onComplete: {
        isUserLoggedIn = true
      })
    } else {
      NavigationStack(path: $coordinator.navigationPath) {
        MainTabViewWrapperView(
          navigationStream: coordinator.eventSubject,
          localStorageUsecase: LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
        )
        .navigationDestination(for: FeatureRoute.self) { route in
          RootViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
        }
      }
      .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
        fullScreenCoverContent()
      }
      .toast(isPresented: isUserLoggedIn, text: "로그인 되었습니다!")
    }
  }

  @ViewBuilder
  private func fullScreenCoverContent() -> some View {
    if let route = coordinator.fullScreenRoute {
      NavigationStack(path: $coordinator.fullScreenPath) {
        RootViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
          .navigationDestination(for: FeatureRoute.self) { route in
            RootViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
          }
      }
    }
  }
}
