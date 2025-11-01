//
//  SettingRoute.swift
//  Router
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation

public struct SettingRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case setting
    case notification
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
