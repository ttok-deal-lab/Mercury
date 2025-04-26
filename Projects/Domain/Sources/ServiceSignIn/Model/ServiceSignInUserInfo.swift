//
//  ServiceSignInUserInfo.swift
//  Domain
//
//  Created by 송하민 on 4/9/25.
//

import Foundation

public enum ServiceSignInStatus: String {
  case active = "ACTIVE"
  case inactive = "INACTIVE"
}

public struct UserInformation {
  public let id: Int
  public let email: String
  public let name: String
  public let status: ServiceSignInStatus?
  
  public init(id: Int, email: String, name: String, status: ServiceSignInStatus?) {
    self.id = id
    self.email = email
    self.name = name
    self.status = status
  }
}

extension UserInformation: Codable { // TODO: UserDefaults용으로 채택하나, 기본적으로 Domain 모델들은 Codable사용을 하지 않아야 한다. 더 좋은 방법 구상할 것
  private enum CodingKeys: String, CodingKey {
    case id
    case email
    case name
    case status
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    email = try container.decode(String.self, forKey: .email)
    name = try container.decode(String.self, forKey: .name)
    status = try container.decodeIfPresent(ServiceSignInStatus.self, forKey: .status)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(email, forKey: .email)
    try container.encode(name, forKey: .name)
    try container.encodeIfPresent(status, forKey: .status)
  }
}

extension ServiceSignInStatus: Codable {
  
}
