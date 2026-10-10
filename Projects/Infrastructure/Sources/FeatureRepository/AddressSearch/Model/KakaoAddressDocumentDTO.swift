//
//  KakaoAddressDocumentDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import Domain

/// `GET /v2/local/search/address.json` 의 document
struct KakaoAddressDocumentDTO: Decodable {
  let addressName: String
  /// 경도(문자열)
  let x: String
  /// 위도(문자열)
  let y: String
  let address: KakaoJibunAddressDTO?
  let roadAddress: KakaoRoadAddressDTO?
  
  enum CodingKeys: String, CodingKey {
    case addressName = "address_name"
    case x, y, address
    case roadAddress = "road_address"
  }
  
  func toAddressInfo() -> AddressInfo? {
    guard let latitude = Double(y), let longitude = Double(x) else { return nil }
    return AddressInfo(
      zipCode: roadAddress?.zoneNo.nilIfEmpty,
      roadAddress: roadAddress?.addressName.nilIfEmpty,
      jibunAddress: address?.addressName.nilIfEmpty ?? addressName.nilIfEmpty,
      buildingName: roadAddress?.buildingName?.nilIfEmpty,
      province: address?.region1DepthName.nilIfEmpty ?? roadAddress?.region1DepthName.nilIfEmpty,
      city: address?.region2DepthName.nilIfEmpty ?? roadAddress?.region2DepthName.nilIfEmpty,
      district: address?.region3DepthName.nilIfEmpty ?? roadAddress?.region3DepthName.nilIfEmpty,
      latitude: latitude,
      longitude: longitude
    )
  }
}
