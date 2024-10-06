//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//


import SwiftUI
import Foundation

import Map
import Tutorial
import AppFoundation
import Coordinator

struct AppView: View {
  
  @AppStorage(UserDefaultsKeyDefine.isAppFirst.rawValue) var isAppFirst: Bool = true
  @StateObject private var coordinator = CoordinatorManager()
  
  var body: some View {
    
    NavigationStack(path: $coordinator.path) {
      CoordinatorFactory.build(page: rootPage(), coordinator: coordinator)
        .navigationDestination(for: AppPage.self) { page in
          CoordinatorFactory.build(page: page, coordinator: coordinator)
        }
        .sheet(item: $coordinator.sheet) { page in
          CoordinatorFactory.build(page: page, coordinator: coordinator)
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { page in
          NavigationStack(path: $coordinator.fullScreenCoverPath) {
            CoordinatorFactory.build(page: page, coordinator: coordinator)
              .navigationDestination(for: AppPage.self) { page in
                CoordinatorFactory.build(page: page, coordinator: coordinator)
              }
          }
          
        }
    }
    .environmentObject(coordinator)

  }
  
  private func rootPage() -> AppPage {
    guard let root = coordinator.rootPage else {
      return isAppFirst ? .tutorial(.tutorialIntro) : .map
    }
    return root
  }
}

#Preview {
  AppView()
    .environmentObject(CoordinatorManager())
}

