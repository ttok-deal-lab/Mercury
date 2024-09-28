//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//

import Map
import Tutorial
import SwiftUI
import Foundation
import AppFoundation
import ComposableArchitecture

struct AppView: View {
  @Perception.Bindable private var store: StoreOf<AppFeature>
  
  init(store: StoreOf<AppFeature>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStackStore(
      self.store.scope(state: \.path, action: \.path)
    ) {
      ZStack {
        Button {
          store.send(.navigateToMap)
        } label: {
          Text("goto map")
        }
      }
      .onAppear {
        if store.isAppFirst {
          store.send(.navigateToTutorial)
        }
      }
    } destination: { store in
      switch store.state {
      case .map:
        if let store = store.scope(state: \.map, action: \.map) {
          MapContentView(store: store)
        }
      case .tutorial:
        if let store = store.scope(state: \.tutorial, action: \.tutorial) {
          TutorialView(store: store)
        }
      }
    }
  }
}

