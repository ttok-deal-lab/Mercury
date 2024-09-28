//
//  Path.swift
//  MercuryApp
//
//  Created by 송하민 on 9/28/24.
//

import Foundation
import ComposableArchitecture
import Tutorial
import Map

@Reducer
struct Path {
  
  @ObservableState
  enum State: Equatable {
    case tutorial(TutorialFeature.State)
    case map(MapFeature.State = .init())
  }
  
  enum Action {
    case tutorial(TutorialFeature.Action)
    case map(MapFeature.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.tutorial, action: \.tutorial) {
      TutorialFeature()
    }
    Scope(state: \.map, action: \.map) {
      MapFeature()
    }
  }
}
