//
//  UserAccessToken.swift
//  Domain
//
//  Created by 송하민 on 4/9/25.
//

import Foundation

public struct UserAccessToken {
  public let accessToken: String
  
  public init(accessToken: String) {
    self.accessToken = accessToken
  }
}

extension UserAccessToken: Codable {
  
}
