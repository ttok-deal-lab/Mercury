//
//  SignInTokenManager.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation
import Combine

public class SignInInformationManager: SignInInformable {
  
  public var signInInformation: PassthroughSubject<SignInInformation, Never> = .init()
  
  public static var shared = SignInInformationManager()
  private init() {
    // AppDelegate 에서 엑세스 토큰 있으면, 자동로그인, 없으면 실패처리 // 1
    tryAutoSignIn()
  }
  
  private func tryAutoSignIn() {
    
  }
  
  
}

// AppDelegate 에서 엑세스 토큰 있으면, 자동로그인, 없으면 실패처리 // 1
// 그러니까 엑세스 토큰을 저장하는 녀석이 필요하다. // 2
// 이와는 별개로 저장한 녀석에 대한 CurrentValueSubject가 필요. // 3

