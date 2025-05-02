
import Foundation

import AppFoundation
import Domain

import NidThirdPartyLogin
import NidLogin

class NaverSignInProvider: NSObject, OauthSignInable {
  
  // MARK: - private property
  
  private var continuation: CheckedContinuation<OauthSignInToken, Error>?

  // MARK: - internal method

  @MainActor
    func signIn() async throws -> OauthSignInToken {
        return try await withCheckedThrowingContinuation { continuation in
            NidOAuth.shared.requestLogin { result in
                switch result {
                case .success(let loginResult):
                    let token = loginResult.accessToken.tokenString
                    continuation.resume(returning: token)
                case .failure(let error):
                    let mercuryError = MercuryError(code: (error as NSError).code)
                    continuation.resume(throwing: mercuryError)
                    
                }
            }
        }
    }
}

