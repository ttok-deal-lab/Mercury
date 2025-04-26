//
//  FcmTokenUsecase.swift
//  Domain
//
//  Created by 송하민 on 4/24/25.
//

import Foundation
import UIKit

import AppFoundation

public final class FcmTokenUsecase: FcmTokenUsecasable {
  @LazyInject private var userInfoManager: UserInfoManagable
  private let repoistory: FcmTokenRepositorable
  
  public init(repository: FcmTokenRepositorable) {
    self.repoistory = repository
  }
  
  public func sendFcmToken(fcmToken: String?) async throws {
    guard let userId = userInfoManager.userInfoStream.value?.id
    else {
      throw MercuryError(.notFoundUser)
    }
    guard let deviceId = await UIDevice.current.identifierForVendor?.uuidString
    else {
      throw MercuryError(.notFoundDeviceUUID)
    }
    let stringifiedUserId = String(userId)
    let deviceType: String = "iOS"
    try await self.repoistory.sendFcmToken(fcmToken: fcmToken ?? "", userId: stringifiedUserId, deviceId: deviceId, deviceType: deviceType)
  }
}
