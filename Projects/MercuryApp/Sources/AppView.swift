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

