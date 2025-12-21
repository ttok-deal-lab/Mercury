//
//  UserProfileInfoDTO.swift
//  MyPage
//
//  Created by 최수훈 on 10/29/25.
//

import Foundation

import MyPage
import Domain

struct UserProfileInfoDTO: Codable {
  let id: Int
  let oauthId: String
  let provider: OauthProvider
  let email: String
  let name: String
  let status: String
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.oauthId = try container.decode(String.self, forKey: .oauthId)
    self.provider = try container.decode(OauthProvider.self, forKey: .provider)
    self.email = try container.decode(String.self, forKey: .email)
    self.name = try container.decode(String.self, forKey: .name)
    self.status = try container.decode(String.self, forKey: .status)
  }
  
  func toUserProfileInfo() -> UserProfileInfo {
    return .init(
      id: self.id,
      oauthId: self.oauthId,
      provider: self.provider,
      email: self.email,
      name: self.name,
      status: UserStatus(rawValue: self.status)
    )
  }
}
