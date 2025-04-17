//
//  SignInRoute.swift
//  Coordinator
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

public struct SignInStep: Hashable {
  public private(set) var step: Step
  
  public init(step: Step) {
    self.step = step
  }
  
  public enum Step: Hashable {
    case signIn
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(step)
  }
}
