//
//  SignInTokenManager.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation
import Combine

import AppFoundation
import Domain
import Infrastructure

public final class SignInInformationManager: SignInInformationReadable, AccessTokenManagable, UserInfoManagable {

  private let localStorageUsecase: LocalStorageUsecase
  private let fcmTokenUsercase: FcmTokenUsecase
  
  private var store = Set<AnyCancellable>()
  
  public private(set) var tokenInfoStream: CurrentValueSubject<UserAccessToken?, Never> = .init(nil)
  public private(set) var userInfoStream: CurrentValueSubject<UserInformation?, Never> = .init(nil)
  
  public var accessToken: UserAccessToken? {
    didSet {
      if let accessToken = accessToken {
        self.tokenInfoStream.send(accessToken)
        Task { [weak self] in
          await self?.localStorageUsecase.setModel(accessToken, forKey: .signInTokenInfo)
        }
      } else {
        self.tokenInfoStream.send(nil)
        Task { [weak self] in
          await self?.localStorageUsecase.remove(forKey: .signInTokenInfo)
        }
      }
    }
  }
  
  public var userInfo: UserInformation? {
    didSet {
      if let userInfo {
        userInfoStream.send(userInfo)
        Task { [weak self] in
          await self?.localStorageUsecase.setModel(userInfo, forKey: .signInUserInfo)
        }
      } else {
        userInfoStream.send(nil)
        Task { [weak self] in
          await self?.localStorageUsecase.remove(forKey: .signInUserInfo)
        }
      }
    }
  }
  
  // MARK: - life cycle

  public static let shared = SignInInformationManager()
  
  private init(
    localStorageUsecase: LocalStorageUsecase = LocalStorageUsecase(repository: UserDefaultsStoreRepository()),
    fcmTokenUsecase: FcmTokenUsecase = FcmTokenUsecase(repository: FcmTokenRepository())
  ) {
    self.localStorageUsecase = localStorageUsecase
    self.fcmTokenUsercase = fcmTokenUsecase
    
    self.tryAutoSignIn()
  }
  
  
  // MARK: - private method
  
  private func tryAutoSignIn() {
    Task {
      async let storedToken = localStorageUsecase.getModel(forKey: .signInTokenInfo, as: UserAccessToken.self)
      async let storedUser = localStorageUsecase.getModel(forKey: .signInUserInfo, as: UserInformation.self)

      if let token = await storedToken {
        self.accessToken = token
      }
      if let user = await storedUser {
        self.userInfo = user
      }
    }
  }
  
  
  // MARK: - public method
  
  public func setAccessToken(_ accessToken: UserAccessToken?) {
    self.accessToken = accessToken
  }
  
  public func removeAccessToken() { // logout
    self.accessToken = nil
  }
  
  public func setUserInfo(_ info: UserInformation?) {
    self.userInfo = info
  }
  
  public func setFcmToken(_ fcmToken: String?) {
    Task {
      do {
        try await self.fcmTokenUsercase.sendFcmToken(fcmToken: fcmToken)
      } catch {
        print("fcm token 등록 실패: \(error)")
      }
    }
  }
  
}
