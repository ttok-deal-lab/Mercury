//
//  PlaceSearchModelData.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import AppFoundation
import Domain

@Observable
final class PlaceSearchModelData {
  // MARK: - internal property
  var query: String = ""
  var results: [AddressInfo] = []
  /// 한 번이라도 검색했는지 (검색 전에는 검색 가이드, 후에는 결과/빈 화면)
  var hasSearched: Bool = false
  var isLoading: Bool = false
  var error: Error?
  
  // MARK: - private property
  private let addressSearchUsecase: AddressSearchUsecasable
  
  // MARK: - life cycle
  init(addressSearchUsecase: AddressSearchUsecasable) {
    self.addressSearchUsecase = addressSearchUsecase
  }
  
  // MARK: - internal method
  func search() async {
    let keyword = query.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !keyword.isEmpty else { return }
    isLoading = true
    defer { isLoading = false }
    do {
      results = try await addressSearchUsecase.searchAddress(query: keyword)
      hasSearched = true
    } catch {
      self.error = error.toMercuryError() ?? MercuryError(.unknown)
    }
  }
  
  func clear() {
    query = ""
    results = []
    hasSearched = false
  }
}
