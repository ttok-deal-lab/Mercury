//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//

import Map
import SwiftUI
import Foundation
import AppFoundation
import ComposableArchitecture

struct AppCoordinatorView: View {

  @Perception.Bindable var store: StoreOf<AppCoordinatorReducer>
  
  var body: some View {
    
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      Button {
        
      } label: {
        Text("goto map")
      }

    } destination: { store in
      switch store.state {
      case .mapState:
        if let store = store.scope(state: \.mapState, action: \.mapAction) {
          MapContentView(store: store)
        }
      }
    }
  }
}
