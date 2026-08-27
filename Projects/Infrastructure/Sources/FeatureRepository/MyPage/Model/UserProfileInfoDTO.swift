//
//  UserProfileInfoDTO.swift
//  MyPage
//
//  Created by 최수훈 on 10/29/25.
//

import Foundation

import Domain

/// `GET /v1/users/{userId}` 응답(OpenAPI `SherbetUser`) 매핑.
/// 서버 스키마에 없는 필드를 필수로 디코딩하면 응답 전체가 실패하므로 스펙과 정확히 맞춘다.
struct UserProfileInfoDTO: Codable {
  let id: Int
  let provider: OauthProvider
  let email: String
  let name: String
  let status: String

  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.provider = try container.decode(OauthProvider.self, forKey: .provider)
    self.email = try container.decode(String.self, forKey: .email)
    self.name = try container.decode(String.self, forKey: .name)
    self.status = try container.decode(String.self, forKey: .status)
  }

  func toUserProfileInfo() -> UserProfileInfo {
    return .init(
      id: self.id,
      provider: self.provider,
      email: self.email,
      name: self.name,
      status: UserStatus(rawValue: self.status)
    )
  }
}
