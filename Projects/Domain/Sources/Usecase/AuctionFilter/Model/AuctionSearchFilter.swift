//
//  AuctionSearchFilter.swift
//  Domain
//
//  Created by 송하민 on 12/14/25.
//

import Foundation

public struct AuctionSearchFilter {
  /// 지역(시/도) 및 하위 구/군 정보
  public let regions: [Region]

  /// 건물 유형 (아파트, 빌라, 오피스텔 등)
  public let buildingTypes: [Option]

  /// 유찰 횟수 필터 옵션 (1회 이하, 2회 이하 등)
  public let auctionFailOptions: [Option]

  /// 검증 상태 필터 옵션 (검증됨, 미검증)
  public let verificationOptions: [Option]

  /// 정렬 옵션 (최신순, 가격순, 기일임박순 등)
  public let searchOptions: [Option]

  public init(
    regions: [Region],
    buildingTypes: [Option],
    auctionFailOptions: [Option],
    verificationOptions: [Option],
    searchOptions: [Option]
  ) {
    self.regions = regions
    self.buildingTypes = buildingTypes
    self.auctionFailOptions = auctionFailOptions
    self.verificationOptions = verificationOptions
    self.searchOptions = searchOptions
  }
}

// MARK: - Region

public struct Region: Identifiable, Equatable {
  public var id: String { code }
  
  public let code: String
  public let displayName: String
  public let districts: [District]

  public init(
    code: String,
    displayName: String,
    districts: [District]
  ) {
    self.code = code
    self.displayName = displayName
    self.districts = districts
  }
}

// MARK: - District

public struct District: Identifiable, Equatable {
  public var id: String { code }
  
  public let code: String
  public let displayName: String

  public init(
    code: String,
    displayName: String
  ) {
    self.code = code
    self.displayName = displayName
  }
}

// MARK: - Option (Domain)

public struct Option {
  public let code: String
  public let displayName: String

  public init(
    code: String,
    displayName: String
  ) {
    self.code = code
    self.displayName = displayName
  }
}
