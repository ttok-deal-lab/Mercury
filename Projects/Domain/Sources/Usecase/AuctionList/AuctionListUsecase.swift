//
//  Untitled.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public final class AuctionListUsecase: AuctionListUsecasable {
  private let repository: AuctionListRepositorable
  
  public init(repository: AuctionListRepositorable) {
    self.repository = repository
  }
  
  public func fetchAllList(courtName: String) async throws -> [AuctionItem] {
    return try await self.repository.fetchAllList(courtName: courtName)
  }
  
}
