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
  
  public var expirationDate: Date? {
    let rawToken = value
      .split(separator: " ")
      .last
      .map(String.init) ?? value
    let segments = rawToken.split(separator: ".")
    guard segments.count >= 2 else { return nil }
    
    let payloadSegment = String(segments[1])
    let normalizedPayload = payloadSegment
      .replacingOccurrences(of: "-", with: "+")
      .replacingOccurrences(of: "_", with: "/")
    let padding = String(repeating: "=", count: (4 - normalizedPayload.count % 4) % 4)
    
    guard
      let payloadData = Data(base64Encoded: normalizedPayload + padding),
      let jwtPayload = try? JSONDecoder().decode(JWTPayload.self, from: payloadData)
    else {
      return nil
    }
    
    return Date(timeIntervalSince1970: jwtPayload.exp)
  }
  
  public var isExpired: Bool {
    guard let expirationDate else { return true }
    return expirationDate <= Date()
  }
}

extension UserAccessToken: Codable {
  
}

private struct JWTPayload: Codable {
  let exp: TimeInterval
}
