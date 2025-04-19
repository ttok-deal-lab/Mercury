//
//  OnboardRoute.swift
//  Coordinator
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

public struct OnboardRoute: Hashable {
  public private(set) var route: Route
  public var onComplete: (() -> Void)?

  public init(route: Route, onComplete: (() -> Void)? = nil) {
    self.route = route
    self.onComplete = onComplete
  }

  public enum Route: Hashable {
    case signIn
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }

  public static func == (lhs: OnboardRoute, rhs: OnboardRoute) -> Bool {
    lhs.route == rhs.route
  }
}
