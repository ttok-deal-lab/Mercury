//
//  AuctionSearchFilterUsecase.swift
//  Domain
//
//  Created by 송하민 on 12/14/25.
//

import Foundation

public final class AuctionSearchFilterUsecase: AuctionSearchFilterUsecasable {
  
  private let repository: AuctionSearchFilterRepositorable
  
  public init(repository: AuctionSearchFilterRepositorable) {
    self.repository = repository
  }
  
  public func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter {
    return try await repository.fetchAuctionSearchFilters()
  }
  
}
