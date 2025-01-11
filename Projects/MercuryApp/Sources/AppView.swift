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

struct AppView: View {
  @StateObject private var coordinator = GlobalCoordinator<GlobalRoute>()
  
  var body: some View {
    NavigationStack(path: $coordinator.routePath.navigationPath) {
      FakeHomeView()
        .adjustCoordinator(factory: AppFactoryAggregator())
    }
    .environmentObject(coordinator)
  }
}


struct FakeHomeView: View {
  @EnvironmentObject private var coordinator: GlobalCoordinator<GlobalRoute>
  
  var body: some View {
    Button {
      coordinator.presentFullScreen(.signIn(.init(route: .signIn)))
    } label: {
      Text("go tutorial")
    }
  }
}
