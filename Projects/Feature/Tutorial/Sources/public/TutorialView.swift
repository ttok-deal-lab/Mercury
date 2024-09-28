//
//  TutorialView.swift
//  Tutorial
//
//  Created by 송하민 on 9/28/24.
//

import SwiftUI
import ComposableArchitecture
import AppFoundation

public struct TutorialView: View {
  
  @Perception.Bindable private var store: StoreOf<TutorialFeature>
  
  public init(store: StoreOf<TutorialFeature>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
      TutorialStep1(store: self.store)
    } destination: { stepStore in
      switch stepStore.state {
      case .step1:
        TutorialStep1(store: self.store)
      case .step2:
        TutorialStep2(store: self.store)
      case .step3:
        TutorialStep3(store: self.store)
      }
    }
  }
  
}
