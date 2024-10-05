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
  
  @EnvironmentObject private var coordinator: CoordinatorManager
  @AppStorage(UserDefaultsKeyDefine.isAppFirst.rawValue) var isAppFirst: Bool = true
  
  var body: some View {
    
    NavigationStack(path: $coordinator.path, root: {
      CoordinatorViewFactory.build(page: isAppFirst ? .tutorialIntro : .map)
        .navigationDestination(for: AppPage.self) { page in
          CoordinatorViewFactory.build(page: page)
        }
        .sheet(item: $coordinator.sheet) { page in
          CoordinatorViewFactory.build(page: page)
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { page in
          CoordinatorViewFactory.build(page: page)
        }
    })
  }
}

#Preview {
  AppView()
    .environmentObject(CoordinatorManager())
}

