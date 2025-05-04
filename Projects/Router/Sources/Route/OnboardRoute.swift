//
//  OnboardRoute.swift
//  Coordinator
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

public struct OnboardRoute: Hashable {
  public private(set) var route: Route

  public init(route: Route) {
    self.route = route
  }

  public enum Route: Hashable {
    case permissionRequest
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }

  public static func == (lhs: OnboardRoute, rhs: OnboardRoute) -> Bool {
    lhs.route == rhs.route
  }
}
