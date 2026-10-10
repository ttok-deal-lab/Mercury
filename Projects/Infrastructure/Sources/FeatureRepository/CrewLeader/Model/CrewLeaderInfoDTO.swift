//
//  CrewLeaderInfoDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import Domain

/// `GET /v1/users/{userId}/crew-leaders` 응답(OpenAPI `CrewLeader`) 매핑.
/// 스펙에 required 가 없어 전부 optional 로 받는다.
struct CrewLeaderInfoDTO: Decodable {
  let crewLeaderUserId: Int?
  let leaderName: String?
  let introduction: String?
  let status: String?
  let statusReason: String?
  let averageRating: Double?
  let reviewCount: Int?
  let snsLinks: [String]?
  let activityRegion: String?
  let certifications: String?
  let contact: String?
  let investmentAssets: Int?
  let investmentYears: Int?
  
  func toCrewLeaderInfo(fallbackUserId: Int) -> CrewLeaderInfo {
    CrewLeaderInfo(
      userId: crewLeaderUserId ?? fallbackUserId,
      name: leaderName,
      introduction: introduction,
      status: status.flatMap(CrewLeaderStatusType.init(rawValue:)),
      statusReason: statusReason,
      averageRating: averageRating,
      reviewCount: reviewCount,
      snsLinks: snsLinks ?? [],
      activityRegion: activityRegion,
      certifications: certifications,
      contact: contact,
      investmentAssets: investmentAssets,
      investmentYears: investmentYears
    )
  }
}
