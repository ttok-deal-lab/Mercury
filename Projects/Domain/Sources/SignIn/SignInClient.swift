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
  public var appleSignIn: () -> AsyncStream<Result<SignInToken, MercuryError>>
//  public var googleSignIn: () async throws -> SignInToken
  
  public init(appleSignIn: @escaping () -> AsyncStream<Result<SignInToken, MercuryError>>) {
    self.appleSignIn = appleSignIn
  }
}

extension SignInClient: DependencyKey {
  public static let liveValue: SignInClient = Self(
    appleSignIn: {
      AsyncStream { continuation in
        Task {
          do {
            let signInToken = try await AppleSignInManager().signIn()
            continuation.yield(.success(signInToken))
          } catch {
            if let error = error as? MercuryError {
              continuation.yield(.failure(error))
            } else {
              continuation.yield(.failure(.init(from: .ownModule(.appleSignin), .unknown)))
            }
          }
          continuation.finish()
        }
      }
    }
  )
}

extension DependencyValues {
  public var signInClient: SignInClient {
    get { self[SignInClient.self] }
    set { self[SignInClient.self] = newValue }
  }
}
