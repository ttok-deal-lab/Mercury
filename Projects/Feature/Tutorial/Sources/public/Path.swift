//
//  Path.swift
//  Tutorial
//
//  Created by 송하민 on 9/28/24.
//

import Foundation
import AppFoundation
import ComposableArchitecture

@Reducer
public struct Path {
  @ObservableState
  public enum State {
    case step1
    case step2
    case step3
  }
  
  public enum Action: Equatable { }
}
