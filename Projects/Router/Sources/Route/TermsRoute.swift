//
//  AgreementRoute.swift
//  Router
//
//  Created by 최수훈 on 11/8/25.
//

import Foundation

public struct TermsRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case termsList
    case memberAgreement
    case privacyPolicy
    case servicePolicy
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
