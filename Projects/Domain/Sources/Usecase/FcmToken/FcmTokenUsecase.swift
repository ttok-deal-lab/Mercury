//
//  FcmTokenUsecase.swift
//  Domain
//
//  Created by 송하민 on 4/24/25.
//

import Foundation

import AppFoundation

public final class FcmTokenUsecase: FcmTokenUsecasable {
  @LazyInject private var userInfoManager: UserInfoManagable
  private let repoistory: FcmTokenRepositorable

  public init(repository: FcmTokenRepositorable) {
    self.repoistory = repository
  }

  public func sendFcmToken(fcmToken: String?, deviceId: String) async throws {
    guard let userId = userInfoManager.userInfoStream.value?.id else {
      throw MercuryError(.notFoundUser)
    }
    let deviceType: String = "ios"
    try await self.repoistory.sendFcmToken(fcmToken: fcmToken ?? "", userId: userId, deviceId: deviceId, deviceType: deviceType)
  }
}
