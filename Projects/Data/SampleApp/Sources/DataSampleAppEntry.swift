//
//  DataSampleAppEntry.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import Data
import SwiftUI
import ComposableArchitecture

@main
struct DataSampleAppEntry: App {
  var body: some Scene {
    WindowGroup {
      ContentView(
        store: Store(initialState: TestReducer.State(apiResult: ""), reducer: {
          TestReducer()
        })
      )
    }
  }
}
