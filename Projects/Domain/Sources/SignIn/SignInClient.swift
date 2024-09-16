//
//  SignInClient.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation
import ComposableArchitecture

public typealias SignInToken = String

public struct SignInClient {
  public var appleSignIn: () async -> Result<SignInToken, MercuryError>
  public var googleSignIn: () async -> Result<SignInToken, MercuryError>
  
  public init(
    appleSignIn: @escaping () async -> Result<SignInToken, MercuryError>,
    googleSignIn: @escaping () async -> Result<SignInToken, MercuryError>
  ) {
    self.appleSignIn = appleSignIn
    self.googleSignIn = googleSignIn
  }
}

extension SignInClient: DependencyKey {
  public static let liveValue = Self(
    appleSignIn: {
      let signInFactory = SignInFactory()
      let signInResult = await signInFactory.appleSigner().signIn()
      return signInResult
    },
    googleSignIn: {
      let signInFactory = SignInFactory()
      let signInResult = await signInFactory.googleSigner().signIn()
      return signInResult
    }
  )
}

extension DependencyValues {
  public var signInClient: SignInClient {
    get { self[SignInClient.self] }
    set { self[SignInClient.self] = newValue }
  }
}
