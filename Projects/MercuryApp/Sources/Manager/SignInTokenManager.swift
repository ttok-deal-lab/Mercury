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

public final class SignInInformationManager: SignInTokenInformable, SignInUserInformable {
  public private(set) var tokenInfo: CurrentValueSubject<UserAccessTokenInfo?, Never> = .init(nil)
  public private(set) var userInfo: CurrentValueSubject<ServiceSignInUserInfo?, Never> = .init(nil)
  
  private let localStorageUsecase: LocalStorageUsecase
  private var store = Set<AnyCancellable>()
  
  // MARK: - life cycle
  
  public static let shared = SignInInformationManager()
  
  private init(localStorageUsecase: LocalStorageUsecase = LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())) {
    self.localStorageUsecase = localStorageUsecase
    bind()
    loadStoredValues()
  }
}

private extension SignInInformationManager {
  
  func bind() {
    tokenInfo
      .dropFirst()
      .sink { [weak self] token in
        Task { [weak self] in
          await self?.localStorageUsecase.setModel(token, forKey: .signInTokenInfo)
        }
      }
      .store(in: &store)
    
    userInfo
      .dropFirst()
      .sink { [weak self] user in
        Task { [weak self] in
          await self?.localStorageUsecase.setModel(user, forKey: .signInUserInfo)
        }
      }
      .store(in: &store)
  }
  
  func loadStoredValues() {
    Task {
      async let storedToken = localStorageUsecase.getModel(forKey: .signInTokenInfo, as: UserAccessTokenInfo.self)
      async let storedUser = localStorageUsecase.getModel(forKey: .signInUserInfo, as: ServiceSignInUserInfo.self)

      if let token = await storedToken {
        tokenInfo.send(token)
      }
      if let user = await storedUser {
        userInfo.send(user)
      }
    }
  }
}
