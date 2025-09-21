//
//  Untitled.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public final class AuctionSalesListUsecase: AuctionSalesListUsecasable {
  private let repository: AuctionSalesListRepositorable
  
  public init(repository: AuctionSalesListRepositorable) {
    self.repository = repository
  }
  
  public func fetchAllSalesList() async throws -> AuctionSales {
    return try await self.repository.fetchAllSalesList()
  }
  
}
