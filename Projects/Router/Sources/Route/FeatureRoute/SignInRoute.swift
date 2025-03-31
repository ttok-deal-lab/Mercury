//
//  SignInRoute.swift
//  Coordinator
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

public struct SignInRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case signIn
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
