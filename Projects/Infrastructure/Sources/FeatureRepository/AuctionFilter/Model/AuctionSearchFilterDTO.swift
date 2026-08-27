//
//  AuctionSearchMetadataDTO.swift
//  Infrastructure
//
//  Created by 송하민 on 12/14/25.
//

import Foundation

import Domain

struct AuctionSearchFilterDTO: Decodable {
  // 지역(시/도) 및 하위 구/군 정보
  let regions: [RegionDTO]
  
  // 건물 유형 (아파트, 빌라, 오피스텔 등)
  let buildingTypes: [OptionDTO]
  
  // 유찰 횟수 필터 옵션 (1회 이하, 2회 이하 등)
  let auctionFailOptions: [OptionDTO]
  
  // 검증 상태 필터 옵션 (검증됨, 미검증)
  let verificationOptions: [OptionDTO]
  
  // 정렬 옵션 (최신순, 가격순, 기일임박순 등)
  let searchOptions: [OptionDTO]
}

// MARK: - Regions

struct RegionDTO: Decodable {
  let code: String
  let displayName: String
  let districts: [DistrictDTO]
}

struct DistrictDTO: Decodable {
  let code: String
  let displayName: String
}

// MARK: - Generic Options

struct OptionDTO: Decodable {
  let code: String
  let displayName: String
}


// MARK: - Mapping

extension AuctionSearchFilterDTO {
  func toEntity() -> AuctionSearchFilter {
    AuctionSearchFilter(
      regions: regions.map { $0.toEntity() },
      buildingTypes: buildingTypes.map { $0.toEntity() },
      auctionFailOptions: auctionFailOptions.map { $0.toEntity() },
      verificationOptions: verificationOptions.map { $0.toEntity() },
      searchOptions: searchOptions.map { $0.toEntity() }
    )
  }
}

extension RegionDTO {
  func toEntity() -> Region {
    Region(
      code: code,
      displayName: displayName,
      districts: districts.map { $0.toEntity() }
    )
  }
}

extension DistrictDTO {
  func toEntity() -> District {
    District(
      code: code,
      displayName: displayName
    )
  }
}

extension OptionDTO {
  func toEntity() -> Option {
    Option(
      code: code,
      displayName: displayName
    )
  }
}
