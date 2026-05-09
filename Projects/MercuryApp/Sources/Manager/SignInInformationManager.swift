//
//  SignInTokenManager.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation
import Combine
import UIKit

import AppFoundation
import Domain
import Infrastructure

public final class SignInInformationManager: SignInInformationReadable, AccessTokenManagable, UserInfoManagable, AuthorizationRefreshable, AccessTokenInvalidatable {

  private let localStorageUsecase: LocalStorageUsecase
  private let fcmTokenUsercase: FcmTokenUsecase
  
  private var store = Set<AnyCancellable>()
  
  public private(set) var tokenInfoStream: CurrentValueSubject<UserAccessToken?, Never> = .init(nil)
  public private(set) var userInfoStream: CurrentValueSubject<UserInformation?, Never> = .init(nil)
  
  
  public var accessToken: UserAccessToken? {
    didSet {
      if let accessToken = accessToken {
        publishTokenInfoStream(accessToken)
        Task { [weak self] in
          await self?.localStorageUsecase.setModel(accessToken, forKey: LocalStorageKey.signInTokenInfo.rawValue)
        }
      } else {
        publishTokenInfoStream(nil)
        Task { [weak self] in
          await self?.localStorageUsecase.remove(forKey: LocalStorageKey.signInTokenInfo.rawValue)
        }
      }
    }
  }
  
  public var userInfo: UserInformation? {
    didSet {
      if let userInfo {
        publishUserInfoStream(userInfo)
        Task { [weak self] in
          await self?.localStorageUsecase.setModel(userInfo, forKey: LocalStorageKey.signInUserInfo.rawValue)
        }
      } else {
        publishUserInfoStream(nil)
        Task { [weak self] in
          await self?.localStorageUsecase.remove(forKey: LocalStorageKey.signInUserInfo.rawValue)
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

  private func publishTokenInfoStream(_ accessToken: UserAccessToken?) {
    publishOnMainThread { [weak self] in
      self?.tokenInfoStream.send(accessToken)
    }
  }

  private func publishUserInfoStream(_ userInfo: UserInformation?) {
    publishOnMainThread { [weak self] in
      self?.userInfoStream.send(userInfo)
    }
  }

  private func publishOnMainThread(_ publish: @escaping @Sendable () -> Void) {
    if Thread.isMainThread {
      publish()
      return
    }

    DispatchQueue.main.async(execute: publish)
  }

  
  private func tryAutoSignIn() {
    Task { [weak self] in
      guard let self else { return }
      async let storedToken = localStorageUsecase.getModel(forKey: LocalStorageKey.signInTokenInfo.rawValue, as: UserAccessToken.self)
      async let storedUser = localStorageUsecase.getModel(forKey: LocalStorageKey.signInUserInfo.rawValue, as: UserInformation.self)
      
      let token = await storedToken
      let user = await storedUser
      
      guard let token else {
        if user != nil {
          await localStorageUsecase.remove(forKey: LocalStorageKey.signInUserInfo.rawValue)
        }
        return
      }
      
      guard !token.isExpired else {
        self.accessToken = nil
        self.userInfo = nil
        return
      }
      
      self.accessToken = token
      if let user {
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

  public func invalidateAccessToken() {
    self.accessToken = nil
    self.userInfo = nil
    Task { [weak self] in
      await self?.localStorageUsecase.remove(forKey: LocalStorageKey.recentViwedSales.rawValue)
    }
  }

  public func refreshAccessToken(rawValue: String) {
    let hasBearerPrefix = rawValue.hasPrefix("Bearer ")
    let oldPrefix = self.accessToken?.value.prefix(12).description ?? "nil"
    let newPrefix = rawValue.prefix(12).description
    let changed = self.accessToken?.value != rawValue
    print("[TOKEN REFRESH] changed=\(changed) bearer=\(hasBearerPrefix) old=\(oldPrefix)… new=\(newPrefix)… len=\(rawValue.count)")
    guard changed else { return }
    self.accessToken = UserAccessToken(value: rawValue)
  }
  
  public func setUserInfo(_ info: UserInformation?) {
    self.userInfo = info
  }
  
  public func setFcmToken(_ fcmToken: String?) {
    Task {
      guard let deviceId = await UIDevice.current.identifierForVendor?.uuidString else {
        print("fcm token 등록 실패: device UUID를 가져올 수 없음")
        return
      }
      do {
        try await self.fcmTokenUsercase.sendFcmToken(fcmToken: fcmToken, deviceId: deviceId)
      } catch {
        print("fcm token 등록 실패: \(error)")
      }
    }
  }
  
}
