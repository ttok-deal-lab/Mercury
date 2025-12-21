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
    case termsDetail(detailItemType: TermsDetailRoute)
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}


public enum TermsDetailRoute: CaseIterable {
  case memberAgreement
  case pivacyPolicy
  case servicewPolicy
}

public extension TermsDetailRoute {
  func toURL(urlString: String) -> URL? {
    return URL(string: urlString)
  }
}
