//
//  UserProfileInfo.swift
//  MyPage
//
//  Created by 최수훈 on 10/29/25.
//

import Foundation

public struct UserProfileInfo {
  public let id: Int
  public let oauthId: String
  public let provider: OauthProvider
  public let email: String
  public let name: String
  public let status: UserStatus?
  
  public init(
    id: Int,
    oauthId: String,
    provider: OauthProvider,
    email: String,
    name: String,
    status: UserStatus?
  ) {
    self.id = id
    self.oauthId = oauthId
    self.provider = provider
    self.email = email
    self.name = name
    self.status = status
  }
}

extension UserProfileInfo: Codable {
  private enum CodingKeys: String, CodingKey {
    case id, oauthId, provider, email, name, status
  }
  
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.oauthId = try container.decode(String.self, forKey: .oauthId)
    self.provider = try container.decode(OauthProvider.self, forKey: .provider)
    self.email = try container.decode(String.self, forKey: .email)
    self.name = try container.decode(String.self, forKey: .name)
    self.status = try container.decodeIfPresent(UserStatus.self, forKey: .status)
  }
  
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.oauthId, forKey: .oauthId)
    try container.encode(self.provider, forKey: .provider)
    try container.encode(self.email, forKey: .email)
  }
}

