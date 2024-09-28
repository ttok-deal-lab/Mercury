//
//  ContnetView.swift
//  AppleSignInSampleApp
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import Tutorial
import ComposableArchitecture

struct ContentView: View {
  var body: some View {
    TutorialView(store: Store(initialState: TutorialFeature.State(), reducer: {
      TutorialFeature()
    }))
  }
}
