//
//  CrewLeaderInfo.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

/// 현재 로그인한 사용자의 임장크루장 정보.
public struct CrewLeaderInfo: Sendable {
  public let userId: Int
  public let name: String?
  public let introduction: String?
  public let status: CrewLeaderStatusType?
  public let statusReason: String?
  public let averageRating: Double?
  public let reviewCount: Int?
  public let snsLinks: [String]
  public let activityRegion: String?
  public let certifications: String?
  public let contact: String?
  public let investmentAssets: Int?
  public let investmentYears: Int?
  
  /// 승인된 크루장인지
  public var isActive: Bool {
    status == .active
  }
  
  public init(
    userId: Int,
    name: String?,
    introduction: String?,
    status: CrewLeaderStatusType?,
    statusReason: String?,
    averageRating: Double?,
    reviewCount: Int?,
    snsLinks: [String],
    activityRegion: String?,
    certifications: String?,
    contact: String?,
    investmentAssets: Int?,
    investmentYears: Int?
  ) {
    self.userId = userId
    self.name = name
    self.introduction = introduction
    self.status = status
    self.statusReason = statusReason
    self.averageRating = averageRating
    self.reviewCount = reviewCount
    self.snsLinks = snsLinks
    self.activityRegion = activityRegion
    self.certifications = certifications
    self.contact = contact
    self.investmentAssets = investmentAssets
    self.investmentYears = investmentYears
  }
}
