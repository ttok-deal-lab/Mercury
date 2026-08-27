//
//  UserInfoDTO.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import Domain

struct UserInfoDTO: Codable, Sendable {
  var user: SignInUserInfoDTO
  var token: SignInTokenInfoDTO
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try container.decode(SignInUserInfoDTO.self, forKey: .user)
    self.token = try container.decode(SignInTokenInfoDTO.self, forKey: .token)
  }
  
  func toUserAccessToken() -> UserAccessToken {
    return .init(
      value: self.token.accessToken
    )
  }
  
  func toUserInformation() -> UserInformation {
    return .init(
      id: self.user.id,
      email: self.user.email,
      name: self.user.name,
      status: UserStatus(rawValue: self.user.status) 
    )
  }
}

struct SignInUserInfoDTO: Codable, Sendable {
  let id: Int
  let email: String
  let name: String
  let provider: String
  let status: String
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    // 카카오 이메일 제공 미동의 시 서버가 빈 값 또는 필드 누락으로 응답할 수 있다.
    self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
    self.name = try container.decode(String.self, forKey: .name)
    self.provider = try container.decode(String.self, forKey: .provider)
    self.status = try container.decode(String.self, forKey: .status)
  }
}

struct SignInTokenInfoDTO: Codable, Sendable {
  let accessToken: String
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.accessToken = try container.decode(String.self, forKey: .accessToken)
  }
}
