//
//  KakaoCoordAddressDocumentDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import Domain

/// `GET /v2/local/geo/coord2address.json` 의 document (좌표는 요청값을 쓴다)
struct KakaoCoordAddressDocumentDTO: Decodable {
  let address: KakaoJibunAddressDTO?
  let roadAddress: KakaoRoadAddressDTO?
  
  enum CodingKeys: String, CodingKey {
    case address
    case roadAddress = "road_address"
  }
  
  func toAddressInfo(latitude: Double, longitude: Double) -> AddressInfo? {
    guard address != nil || roadAddress != nil else { return nil }
    return AddressInfo(
      zipCode: roadAddress?.zoneNo.nilIfEmpty,
      roadAddress: roadAddress?.addressName.nilIfEmpty,
      jibunAddress: address?.addressName.nilIfEmpty,
      buildingName: roadAddress?.buildingName?.nilIfEmpty,
      province: address?.region1DepthName.nilIfEmpty ?? roadAddress?.region1DepthName.nilIfEmpty,
      city: address?.region2DepthName.nilIfEmpty ?? roadAddress?.region2DepthName.nilIfEmpty,
      district: address?.region3DepthName.nilIfEmpty ?? roadAddress?.region3DepthName.nilIfEmpty,
      latitude: latitude,
      longitude: longitude
    )
  }
}
