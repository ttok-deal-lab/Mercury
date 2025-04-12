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
      FakeHomeView(eventSubject: coordinator.eventSubject)
        .navigationDestination(for: FeatureRoute.self) { route in
          RootViewFactory().makeView(
            route,
            eventSubject: coordinator.eventSubject
          )
        }
    }
    .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
      if let route = coordinator.fullScreenRoute {
        NavigationStack(path: $coordinator.fullScreenPath) {
          RootViewFactory().makeView(route, eventSubject: coordinator.eventSubject)
            .navigationDestination(for: FeatureRoute.self) { route in
              RootViewFactory().makeView(route, eventSubject: coordinator.eventSubject)
            }
        }
      }
    }
  }
}


struct FakeHomeView: View {
  let eventSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(eventSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.eventSubject = eventSubject
  }
  
  var body: some View {
    Button {
      eventSubject.send(.push(.signIn(.init(route: .signIn))))
    } label: {
      Text("go tutorial")
        .fonts(.bodyLargeBold)
    }
  }
}
