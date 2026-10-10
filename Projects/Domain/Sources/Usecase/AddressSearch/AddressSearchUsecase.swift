//
//  AddressSearchUsecase.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

public final class AddressSearchUsecase: AddressSearchUsecasable {
  
  private let repository: AddressSearchRepositoriable
  
  public init(repository: AddressSearchRepositoriable) {
    self.repository = repository
  }
  
  public func searchAddress(query: String) async throws -> [AddressInfo] {
    let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return [] }
    return try await repository.searchAddress(query: trimmed)
  }
  
  public func address(latitude: Double, longitude: Double) async throws -> AddressInfo? {
    try await repository.address(latitude: latitude, longitude: longitude)
  }
}
