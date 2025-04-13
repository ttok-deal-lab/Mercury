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
  
  private let localStorageUsecase = LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
  private var store = Set<AnyCancellable>()
  
  // MARK: - life cycle
  
  public static let shared = SignInInformationManager()
  
  private init() {
    Task {
      tokenInfo
        .dropFirst()
        .sink { tokenInfo in
          Task { [weak self] in
            await self?.localStorageUsecase.setModel(tokenInfo, forKey: .signInTokenInfo)
          }
        }
        .store(in: &store)
      
      userInfo
        .dropFirst()
        .sink { [weak self] userInfo in
          Task { [weak self] in
            await self?.localStorageUsecase.setModel(userInfo, forKey: .signInUserInfo)
          }
        }
        .store(in: &store)
      
      if let signInTokenInfo = await localStorageUsecase.getModel(forKey: .signInTokenInfo, as: UserAccessTokenInfo.self) {
        tokenInfo.send(signInTokenInfo)
      }
      if let signInUserInfo = await localStorageUsecase.getModel(forKey: .signInUserInfo, as: ServiceSignInUserInfo.self) {
        userInfo.send(signInUserInfo)
      }
    }
    
  }
}
