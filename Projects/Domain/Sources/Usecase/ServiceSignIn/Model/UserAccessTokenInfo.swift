//
//  UserAccessToken.swift
//  Domain
//
//  Created by 송하민 on 4/9/25.
//

import Foundation

public struct UserAccessToken {
  public let value: String
  
  public init(value: String) {
    self.value = value
  }
}

extension UserAccessToken: Codable {
  
}
