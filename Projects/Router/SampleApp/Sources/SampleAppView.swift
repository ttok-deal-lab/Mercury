//
//  SampleAppView.swift
//  CoordinatorSampleApp
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Router

struct SampleAppView: View {
  @StateObject var coordinator = NavigationCoordinator<SampleRoute>()
  
  var body: some View {
    NavigationStack(path: $coordinator.rootStack) {
      AView(coordinator: coordinator.eventSubject)
        .navigationDestination(for: SampleRoute.self) { route in
          SampleViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
        }
    }
    .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
      if let route = coordinator.fullScreenRoute {
        NavigationStack(path: $coordinator.fullScreenStack) {
          SampleViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
            .navigationDestination(for: SampleRoute.self) { route in
              SampleViewFactory().makeView(route, navigationStream: coordinator.eventSubject)
            }
        }
      }
    }
    .environmentObject(coordinator)
  }
}
