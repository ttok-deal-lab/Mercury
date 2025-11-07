//
//  AgreementRoute.swift
//  Router
//
//  Created by 최수훈 on 11/8/25.
//

import Foundation

public struct AgreementRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case agreements
    case termsOfUser
    case privacy
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
