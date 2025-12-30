//
//  RecentViewListUsecasable.swift
//  Domain
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

public protocol RecentSalesUsecasable {
  func fetchRecentViewList() async throws -> [RecentSalesItem]
}

