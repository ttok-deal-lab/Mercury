//
//  SampleAppView.swift
//  CoordinatorSampleApp
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Router

struct SampleAppView: View {
  @StateObject private var coordinator = GlobalCoordinator<SampleRoute>()
  
  var body: some View {
    NavigationStack(path: $coordinator.routePath.navigationPath) {
      AView()
        .adjustCoordinator(factory: SampleViewFactory())
    }
    .environmentObject(coordinator)
  }
}
