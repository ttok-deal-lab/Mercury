//
//  Route.swift
//  Tutorial
//
//  Created by 송하민 on 12/23/24.
//

import Foundation

public struct TutorialRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route {
    case intro
    case category
    case region
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
