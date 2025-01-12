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
  private let signInUsecase: SignInUsecase
  private let container: MercuryContainer
  
  init(signInUsecase: SignInUsecase) {
    self.signInUsecase = signInUsecase
    self.container = MercuryContainer.shared
  }
  
  public func oauthSignIn(_ oauthProvider: OauthProvider) async throws {
    let oauthSignInToken = try await signInUsecase.oauthSignIn(oauthProvider)
    print("oauth token ~> \(oauthSignInToken)")
    
    try await serviceSignIn(provider: oauthProvider, oauthSignInToken: oauthSignInToken)
  }
  
  private func serviceSignIn(provider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    let signInInformation = try await signInUsecase.serviceSignIn(oauthProvider: provider, oauthSignInToken: oauthSignInToken)
    let userDefaultsManager = container.resolve(UserDefaultsManagable.self)
    userDefaultsManager.setModel(signInInformation, forKey: .signInInformation)
    
    try await Task.sleep(for: .seconds(1))
    
    let model = userDefaultsManager.getModel(forKey: .signInInformation, as: SignInInformation.self)
    
    print("model ~> \(model)")
  }
  
}
