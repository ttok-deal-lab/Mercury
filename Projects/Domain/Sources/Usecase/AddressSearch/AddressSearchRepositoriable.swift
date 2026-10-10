//
//  AddressSearchRepositoriable.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

public protocol AddressSearchRepositoriable: Sendable {
  /// 지번·도로명·건물명 검색
  func searchAddress(query: String) async throws -> [AddressInfo]
  /// 좌표 → 주소. 바다 등 주소가 없는 곳이면 nil.
  func address(latitude: Double, longitude: Double) async throws -> AddressInfo?
}
