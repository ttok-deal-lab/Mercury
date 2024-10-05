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
      CoordinatorViewFactory.build(page: .map)
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
    .onAppear {
      if isAppFirst {
        self.coordinator.presentFullScreenCover(.tutorialIntro)
      }
    }
//    {
//      if isAppFirst {
//        TutorialIntroView()
//      } else {
//        MapContentView()
//      }
//    }
  }
}

//struct AppView: View {
//  @Perception.Bindable private var store: StoreOf<AppFeature>
//  
//  init(store: StoreOf<AppFeature>) {
//    self.store = store
//  }
//  
//  var body: some View {
//    NavigationStackStore(
//      self.store.scope(state: \.path, action: \.path)
//    ) {
//      ZStack {
//        Button {
//          store.send(.destination(.push(.map)))
//        } label: {
//          Text("goto map")
//        }
//      }
//      .fullScreenCover(store: store.scope(state: \.$tutorial, action: \.tutorial), content: { store in
//        TutorialView(store: store)
//      })
//      .onAppear {
//        if store.isAppFirst {
//          store.send(.destination(.present(.tutorial)))
//        }
//      }
//    } destination: { store in
//      switch store.state {
//      case .map:
//        if let store = store.scope(state: \.map, action: \.map) {
//          MapContentView(store: store)
//        }
//      case .tutorial:
//        if let store = store.scope(state: \.tutorial, action: \.tutorial) {
//          TutorialView(store: store)
//        }
//      }
//    }
//  }
//}

