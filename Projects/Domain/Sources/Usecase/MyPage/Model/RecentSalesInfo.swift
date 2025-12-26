//
//  RecentSalesInfo.swift
//  AuctionHome
//
//  Created by 최수훈 on 12/26/25.
//

import Foundation

public struct RecentSalesInfo: Codable, Equatable {
  let id: Int
  let date: Date
  
  public init(id: Int, date: Date) {
    self.id = id
    self.date = date
  }
  
  public static func == (lhs: RecentSalesInfo, rhs: RecentSalesInfo) -> Bool {
    lhs.id == rhs.id
  }
}
