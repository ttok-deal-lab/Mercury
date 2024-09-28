//
//  TutorialStep1.swift
//  Tutorial
//
//  Created by 송하민 on 9/28/24.
//

import Foundation
import AppFoundation
import SwiftUI
import ComposableArchitecture

public struct TutorialStep3: View {
  
  // MARK: - private property
  
  @Perception.Bindable private var store: StoreOf<TutorialFeature>
  
  
  // MARK: - life cycle
  
  public init(store: StoreOf<TutorialFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("33333")
    Button {
      store.send(.completeTutorial)
    } label: {
      Text("다음")
    }

  }
  
  
}
