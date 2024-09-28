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

@DependencyClient
public struct SignInClient {
  public var appleSignIn: @Sendable () async -> Result<SignInToken, MercuryError>?
  public var googleSignIn: @Sendable () async -> Result<SignInToken, MercuryError>?
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

extension SignInClient: TestDependencyKey {}

extension DependencyValues {
  public var signInClient: SignInClient {
    get { self[SignInClient.self] }
    set { self[SignInClient.self] = newValue }
  }
}
