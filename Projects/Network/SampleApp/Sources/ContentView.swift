//
//  ContentView.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  
  var store: StoreOf<TestReducer>
  
  var body: some View {
    VStack {
      Button {
        store.send(.testAPI)
      } label: {
        Text("test")
      }
      Text(store.apiResult)
    }
    
  }
  
  init(store: StoreOf<TestReducer>) {
    self.store = store
  }
}
