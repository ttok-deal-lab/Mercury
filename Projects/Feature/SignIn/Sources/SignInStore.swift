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

public class SignInStore: ObservableObject {
  
  @Published var error: MercuryError?
  @Published var signInToken: SignInToken?
  
  
  // MARK: - published property
  
  // MARK: - private property
  
  private let signInClient: SignInClient
  
  
  // MARK: - life cycle
  
  init(signInClient: SignInClient) {
    self.signInClient = signInClient
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  @MainActor
  public func signIn(for type: SignInType) async {
    guard let result = await signInClient.signIn(type: type) else {
      self.error = .init(from: .ownModule(.appleSignin), .nilFromSignIn)
      return
    }
    switch result {
    case .success(let signInToken):
      self.signInToken = signInToken
    case .failure(let error):
      self.error = error
    }
  }
  
}
