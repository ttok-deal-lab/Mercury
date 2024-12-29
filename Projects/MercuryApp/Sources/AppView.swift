//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//


import SwiftUI
import Foundation

import AppFoundation
import Coordinator
import Tutorial


struct AppView: View {
  @StateObject private var coordinator = GlobalCoordinator<GlobalRoute>()
  
  var body: some View {
    NavigationStack(path: $coordinator.routePath.navigationPath) {
      FakeHomeView()
        .navigationDestination(for: GlobalRoute.self) { route in
          AppFactoryAggregator.makeView(route)
        }
        .fullScreenCover(isPresented: $coordinator.routePath.isFullScreenPresented) {
          if let route = coordinator.routePath.fullScreenRoute {
            NavigationStack(path: $coordinator.routePath.fullScreenNavigationPath) {
              AppFactoryAggregator.makeView(route)
                .navigationDestination(for: GlobalRoute.self) { route in
                  AppFactoryAggregator.makeView(route)
                }
            }
          }
        }
    }
    .environmentObject(coordinator)
  }
}


struct FakeHomeView: View {
  @EnvironmentObject private var coordinator: GlobalCoordinator<GlobalRoute>
  
  var body: some View {
    Button {
      coordinator.push(.tutorial(.init(route: .intro)))
    } label: {
      Text("go tutorial")
    }
  }
}
