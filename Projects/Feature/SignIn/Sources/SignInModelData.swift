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
  @Published var signInToken: SignInToken?
  
  private let signInUsecase: SignInUsecase
  
  init(signInUsecase: SignInUsecase) {
    self.signInUsecase = signInUsecase
  }
  
  @MainActor public func signIn(signInType: SignInType) {
    Task {
      guard let result = await signInUsecase.signIn(signInType) else {
        self.error = .init(from: .ownModule(.appleSignin), .nilFromSignIn)
        return
      }
      switch result {
      case .success(let signInToken):
        print("signInToken: \(signInToken)")
        self.signInToken = signInToken
      case .failure(let error):
        self.error = error
      }
    }
  }
  
}
