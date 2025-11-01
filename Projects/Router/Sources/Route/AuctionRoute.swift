//
//  AuctionRoute.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import Foundation

public struct AuctionRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case auctionDetail(auctionID: Int)
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
