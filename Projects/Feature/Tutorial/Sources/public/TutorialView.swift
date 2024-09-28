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
    Group {
      switch store.currentStep {
      case 1:
        TutorialStep1(store: store)
      case 2:
        TutorialStep2(store: store)
      case 3:
        TutorialStep3(store: store)
      default:
        EmptyView()
      }
    }
  }
  
}
