//
//  MyPageRoute.swift
//  
//
//  Created by 최수훈 on 11/16/25.
//

import Foundation

public struct MyPageRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case recentlySales
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}

