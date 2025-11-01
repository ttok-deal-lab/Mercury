//
//  FcmTokenUsecasable.swift
//  Domain
//
//  Created by 송하민 on 4/24/25.
//

import Foundation

public protocol FcmTokenUsecasable: Sendable {
  func sendFcmToken(fcmToken: String?) async throws
}

