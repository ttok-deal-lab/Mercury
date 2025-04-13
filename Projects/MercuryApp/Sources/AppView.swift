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

struct AppView: View {
  @StateObject private var coordinator = NavigationCoordinator<FeatureRoute>()
  
  var body: some View {
    NavigationStack(path: $coordinator.navigationPath) {
      TabbarViewWrapperView(navigationSubject: coordinator.eventSubject)
        .navigationDestination(for: FeatureRoute.self) { route in
          RootViewFactory().makeView(route, navigationSubject: coordinator.eventSubject)
        }
    }
    .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
      if let route = coordinator.fullScreenRoute {
        NavigationStack(path: $coordinator.fullScreenPath) {
          RootViewFactory().makeView(route, navigationSubject: coordinator.eventSubject)
            .navigationDestination(for: FeatureRoute.self) { route in
              RootViewFactory().makeView(route, navigationSubject: coordinator.eventSubject)
            }
        }
      }
    }
  }
}


//struct FakeHomeView: View {
//  let navigationEvent: NavigationSubject
//  
//  public init(navigationEvent: NavigationSubject) {
//    self.navigationEvent = navigationEvent
//  }
//  
//  var body: some View {
//    Button {
//      navigationEvent.send(.presentFullScreen(.onboard(SignInRoute(route: .signIn))))
//    } label: {
//      Text("go tutorial")
//        .fonts(.bodyLargeBold)
//    }
//  }
//}
