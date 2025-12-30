//
//  SearchRoute.swift
//  Router
//
//  Created by 송하민 on 12/28/25.
//

import Foundation

public struct SearchRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case searchHome
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
