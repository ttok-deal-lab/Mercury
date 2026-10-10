//
//  AddressInfo.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

/// 주소 검색/좌표 변환 결과 한 건.
public struct AddressInfo: Identifiable, Equatable, Sendable {
  public var id: String { "\(latitude),\(longitude),\(jibunAddress ?? roadAddress ?? "")" }
  
  /// 우편번호(도로명 주소가 있을 때만)
  public let zipCode: String?
  public let roadAddress: String?
  public let jibunAddress: String?
  public let buildingName: String?
  /// 시/도
  public let province: String?
  /// 시/군/구
  public let city: String?
  /// 동/읍/면
  public let district: String?
  public let latitude: Double
  public let longitude: Double
  
  /// 화면 대표 주소. 도로명이 없으면 지번.
  public var displayAddress: String {
    roadAddress ?? jibunAddress ?? ""
  }
  
  public init(
    zipCode: String?,
    roadAddress: String?,
    jibunAddress: String?,
    buildingName: String?,
    province: String?,
    city: String?,
    district: String?,
    latitude: Double,
    longitude: Double
  ) {
    self.zipCode = zipCode
    self.roadAddress = roadAddress
    self.jibunAddress = jibunAddress
    self.buildingName = buildingName
    self.province = province
    self.city = city
    self.district = district
    self.latitude = latitude
    self.longitude = longitude
  }
}
