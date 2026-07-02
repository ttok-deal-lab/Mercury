//
//  FcmTokenRepository.swift
//  Infrastructure
//
//  Created by 송하민 on 4/25/25.
//

import Foundation

import Domain
import Networking

public final class FcmTokenRepository: FcmTokenRepositorable {
  
  public init() { }
  
  public func sendFcmToken(fcmToken: String, userId: Int, deviceId: String, deviceType: String) async throws {
    try await FCMTokenAPI
      .registFCMToken(
        fcmToken: fcmToken,
        userID: userId,
        deviceID: deviceId,
        deviceType: deviceType
      )
      .request()
  }
}
