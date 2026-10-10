//
//  AddressSearchUsecasable.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

public protocol AddressSearchUsecasable: Sendable {
  func searchAddress(query: String) async throws -> [AddressInfo]
  func address(latitude: Double, longitude: Double) async throws -> AddressInfo?
}
