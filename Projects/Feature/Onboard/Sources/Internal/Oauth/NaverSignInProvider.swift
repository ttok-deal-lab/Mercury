
import Foundation

import AppFoundation
import Domain

import NaverThirdPartyLogin

class NaverSignInProvider: NSObject, OauthSignInable {
  
  // MARK: - private property
  
  private let instance = NaverThirdPartyLoginConnection.getSharedInstance()
  private var continuation: CheckedContinuation<OauthSignInToken, Error>?

  // MARK: - internal method
  
  public func logout() {
    instance?.requestDeleteToken()
  }
  
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      self?.instance?.delegate = self
      self?.instance?.requestThirdPartyLogin()
      self?.continuation = continuation
    }
  }
  
  private func naverToken() {
    if let token = self.instance?.accessToken {
      self.continuation?.resume(returning: token)
    } else {
      self.continuation?.resume(throwing: MercuryError(.noOauthToken))
    }
    self.continuation = nil
  }
}


extension NaverSignInProvider: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 성공
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    naverToken()
  }
  
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    naverToken()
  }
  
  func oauth20ConnectionDidFinishDeleteToken() { }
  
  // 로그인 실패
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
    self.continuation?.resume(throwing: error)
    self.continuation = nil
  }
}
