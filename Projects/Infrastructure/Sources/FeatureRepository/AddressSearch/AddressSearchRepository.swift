//
//  AddressSearchRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import Domain

public final class AddressSearchRepository: AddressSearchRepositoriable {
  
  public init() { }
  
  public func searchAddress(query: String) async throws -> [AddressInfo] {
    let response = try await KakaoLocalAPI.searchAddress(query: query)
      .request(KakaoLocalResponseDTO<KakaoAddressDocumentDTO>.self)
    return response.documents.compactMap { $0.toAddressInfo() }
  }
  
  public func address(latitude: Double, longitude: Double) async throws -> AddressInfo? {
    let response = try await KakaoLocalAPI.coordToAddress(latitude: latitude, longitude: longitude)
      .request(KakaoLocalResponseDTO<KakaoCoordAddressDocumentDTO>.self)
    return response.documents.first?.toAddressInfo(latitude: latitude, longitude: longitude)
  }
}
