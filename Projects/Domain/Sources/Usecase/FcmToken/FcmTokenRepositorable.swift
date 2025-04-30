//
//  FcmTokenRepository.swift
//  Domain
//
//  Created by 송하민 on 4/24/25.
//

public protocol FcmTokenRepositorable {
  func sendFcmToken(fcmToken: String, userId: String, deviceId: String, deviceType: String) async throws
}
