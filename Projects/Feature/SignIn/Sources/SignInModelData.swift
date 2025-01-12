//
//  SignInStore.swift
//  SignIn
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import SwiftUI
import Combine
import AppFoundation

import Domain

public class SignInModelData: ObservableObject {
  @Published var error: MercuryError?
  @Published var signInToken: OauthSignInToken? {
    didSet {
      
    }
  }
  
  private let signInUsecase: SignInUsecase
  
  init(signInUsecase: SignInUsecase) {
    self.signInUsecase = signInUsecase
  }
  
  public func oauthSignIn(signInType: OauthProvider) async throws {
    let oauthSignInToken = try await signInUsecase.signIn(signInType)
    self.signInToken = oauthSignInToken
  }
  
}
