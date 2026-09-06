//
//  SettingRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/2/26.
//

import Foundation
import UIKit

import AppFoundation
import Domain

public class SettingRepository: SettingRepositoriable {
  
  private var signininformationManager = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  public init() { }
  public func signOut() async throws {
    
    guard let userID = signininformationManager.userInfo?.id else {
      throw MercuryError(.notFoundUser)
    }
    try await AuthAPI.signOut(userID: userID)
      .request()
  }

  public func logout() async throws {
    guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {
      throw MercuryError(.notFoundDeviceUUID)
    }

    do {
      try await AuthAPI.logout(deviceID: deviceID).request()
    } catch NetworkError.unauthorized {
      // 서버가 로그아웃에도 JWT 검증을 적용한다. 만료 토큰은 이미 로그아웃된 것으로 취급한다.
    }
  }

  
}
