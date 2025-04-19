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

import SwiftUI

private enum AppLaunchState {
  case splash
  case signedOut
  case signedIn
}

struct AppView: View {
  @StateObject private var coordinator = NavigationCoordinator<FeatureRoute>()
  @State private var isSplashDone = false
  @State private var isUserLoggedIn = false

  var body: some View {
    ZStack {
      launchContent()
    }
    .animation(.easeInOut(duration: DesignDefine.transitionOpacityDuration), value: isSplashDone)
  }
}

private extension AppView {
  var launchState: AppLaunchState {
    if !isSplashDone {
      return .splash
    } else {
      return isUserLoggedIn ? .signedIn : .signedOut
    }
  }

  @ViewBuilder
  func launchContent() -> some View {
    switch launchState {
    case .splash:
      splashView()
    case .signedOut:
      signInView()
    case .signedIn:
      mainTabView()
    }
  }
}

private extension AppView {
  func splashView() -> some View {
    CustomSplashViewWrapperView { isLoggedIn in
      self.isUserLoggedIn = isLoggedIn
      self.isSplashDone = true
    }
    .transition(.opacity)
  }

  func signInView() -> some View {
    SignInViewWrapperView(navigationStream: coordinator.eventSubject)
  }

  func mainTabView() -> some View {
    NavigationStack(path: $coordinator.navigationPath) {
      MainTabViewWrapperView(navigationStream: coordinator.eventSubject)
        .navigationDestination(for: FeatureRoute.self) { route in
          RootViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
        }
    }
    .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
      fullScreenView()
    }
  }

  @ViewBuilder
  func fullScreenView() -> some View {
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
