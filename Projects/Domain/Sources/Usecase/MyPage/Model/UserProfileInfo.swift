//
//  UserProfileInfo.swift
//  MyPage
//
//  Created by 최수훈 on 10/29/25.
//

import Foundation

public struct UserProfileInfo {
  public let id: Int
  public let provider: OauthProvider
  public let email: String
  public let name: String
  public let status: UserStatus?

  public init(
    id: Int,
    provider: OauthProvider,
    email: String,
    name: String,
    status: UserStatus?
  ) {
    self.id = id
    self.provider = provider
    self.email = email
    self.name = name
    self.status = status
  }
}

extension UserProfileInfo: Codable {
  private enum CodingKeys: String, CodingKey {
    case id, provider, email, name, status
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.provider = try container.decode(OauthProvider.self, forKey: .provider)
    self.email = try container.decode(String.self, forKey: .email)
    self.name = try container.decode(String.self, forKey: .name)
    self.status = try container.decodeIfPresent(UserStatus.self, forKey: .status)
  }
  
  // 저장 후 다시 읽을 때 name 이 keyNotFound 로 터지지 않도록 디코딩 대상 전체를 인코딩한다.
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.provider, forKey: .provider)
    try container.encode(self.email, forKey: .email)
    try container.encode(self.name, forKey: .name)
    try container.encodeIfPresent(self.status, forKey: .status)
  }
}

