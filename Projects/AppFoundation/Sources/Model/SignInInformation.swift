//
//  SignInInformation.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

public struct SignInInformation: Codable { // UserDefaults에 저장하기 위한 Codable
  public var user: SignInUserInfo
  public var token: SignInTokenInfo
  
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try container.decode(SignInUserInfo.self, forKey: .user)
    self.token = try container.decode(SignInTokenInfo.self, forKey: .token)
  }
  
}

public struct SignInUserInfo: Codable {
  
  public let id: Int
  public let email: String
  public let name: String
  public let provider: String
  public let status: String
  
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.email = try container.decode(String.self, forKey: .email)
    self.name = try container.decode(String.self, forKey: .name)
    self.provider = try container.decode(String.self, forKey: .provider)
    self.status = try container.decode(String.self, forKey: .status)
  }
}

public struct SignInTokenInfo: Codable {
  public let accessToken: String
  public let refreshToken: String
  
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.accessToken = try container.decode(String.self, forKey: .accessToken)
    self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
  }
}
