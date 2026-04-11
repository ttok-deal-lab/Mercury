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
  @Inject private var accessTokenManager: AccessTokenManagable

  var body: some View {
    ZStack {
      currentView()
    }
    .shake(onPresent: {
      self.coordinator.presentFullScreen(.networkConsole)
    })
    .animation(.easeInOut(duration: DesignDefine.transitionOpacityDuration), value: isSplashDone)
    .environmentObject(coordinator)
    .onReceive(accessTokenManager.tokenInfoStream) { token in
      guard isSplashDone else { return }
      let loggedIn = token != nil
      guard isUserLoggedIn != loggedIn else { return }
      if !loggedIn {
        coordinator.popToRoot()
      }
      isUserLoggedIn = loggedIn
    }
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
      NavigationStack(path: $coordinator.rootStack) {
        MainTabViewWrapperView()
        .navigationDestination(for: FeatureRoute.self) { route in
          RootViewFactory().makeView(route)
        }
      }
      .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
        fullScreenCoverContent()
          .environmentObject(coordinator)
      }
      .toast(isPresented: isUserLoggedIn, text: "로그인 되었습니다!")
    }
  }

  @ViewBuilder
  private func fullScreenCoverContent() -> some View {
    if let route = coordinator.fullScreenRoute {
      NavigationStack(path: $coordinator.fullScreenStack) {
        RootViewFactory().makeView(route)
          .navigationDestination(for: FeatureRoute.self) { route in
            RootViewFactory().makeView(route)
          }
      }
    }
  }
}
