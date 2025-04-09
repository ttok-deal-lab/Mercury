//
//  SignInInformationDTO.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

struct SignInInformationDTO: Codable {
  var user: SignInUserInfoDTO
  var token: SignInTokenInfoDTO
  
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try container.decode(SignInUserInfoDTO.self, forKey: .user)
    self.token = try container.decode(SignInTokenInfoDTO.self, forKey: .token)
  }
  
}

struct SignInUserInfoDTO: Codable {
  let id: Int
  let email: String
  let name: String
  let provider: String
  let status: String
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.email = try container.decode(String.self, forKey: .email)
    self.name = try container.decode(String.self, forKey: .name)
    self.provider = try container.decode(String.self, forKey: .provider)
    self.status = try container.decode(String.self, forKey: .status)
  }
}

struct SignInTokenInfoDTO: Codable {
  let accessToken: String
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.accessToken = try container.decode(String.self, forKey: .accessToken)
  }
}
