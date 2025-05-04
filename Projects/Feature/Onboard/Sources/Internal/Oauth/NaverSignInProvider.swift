
import Foundation

import AppFoundation
import Domain

import NidThirdPartyLogin
import NidLogin

class NaverSignInProvider: NSObject, OauthSignInable {
  
  private let userCancelCode: Int = .zero
  
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      NidOAuth.shared.requestLogin { result in
        switch result {
        case .success(let loginResult):
          let token = loginResult.accessToken.tokenString
          if loginResult.accessToken.isExpired {
            let refreshToken = loginResult.refreshToken.tokenString
            continuation.resume(returning: refreshToken)
            return
          }
          continuation.resume(returning: token)
        case .failure(let error):
          guard (error as NSError).code != self?.userCancelCode else { return }
          continuation.resume(throwing: MercuryError(code: (error as NSError).code))
        }
      }
    }
  }
}

