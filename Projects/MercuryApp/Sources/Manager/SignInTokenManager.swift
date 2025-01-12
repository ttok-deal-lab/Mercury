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
  public private(set) var tokenInfo: PassthroughSubject<SignInTokenInfo, Never> = .init()
  public private(set) var userInfo: PassthroughSubject<SignInUserInfo, Never> = .init()
  
  private let localStorageUsecase = LocalStorageUsecase(localStorageClient: UserDefaultsClient.shared)
  
  public static var shared = SignInInformationManager()
  private init() {
    initializeSignInInfo()
  }
  
  private func initializeSignInInfo() {
    if let signInTokenInfo = localStorageUsecase.getModel(forKey: .signInTokenInfo, as: SignInTokenInfo.self) {
      tokenInfo.send(signInTokenInfo)
    }
    if let signInUserInfo = localStorageUsecase.getModel(forKey: .signInUserInfo, as: SignInUserInfo.self) {
      userInfo.send(signInUserInfo)
    }
  }
}
