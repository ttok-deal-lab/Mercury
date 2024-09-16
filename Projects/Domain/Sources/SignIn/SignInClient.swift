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
      do {
        let signInFactory = SignInFactory()
        let signInToken = try await signInFactory.appleSigner().signIn()
        return .success(signInToken)
      } catch {
        if let error = error as? MercuryError {
          return .failure(error)
        } else {
          return .failure(.init(from: .ownModule(.appleSignin), .unknown))
        }
      }
    },
    googleSignIn: {
      return .failure(.init(from: .server, .unknown))
    }
  )
}

extension DependencyValues {
  public var signInClient: SignInClient {
    get { self[SignInClient.self] }
    set { self[SignInClient.self] = newValue }
  }
}
