
import Foundation

import AppFoundation

import NaverThirdPartyLogin

class NaverSignInProvider: NSObject, UIApplicationDelegate,  SignInable {
  
  // MARK: - private property
  private let instance = NaverThirdPartyLoginConnection.getSharedInstance()
  private var continuation: CheckedContinuation<OauthSignInToken, Error>?
  private var sldfj = ""
  // MARK: - internal method
  public func logout() {
    instance?.requestDeleteToken()
  }
  
  func signIn() async throws -> OauthSignInToken {
    guard let instance = instance else {
      throw MercuryError(from: .ownModule(.naverSignin), .unknown)
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      instance.delegate = self
      instance.requestThirdPartyLogin()
      self.continuation = continuation
    }
  }
  
  private func getNaverToken() {
    if let token = self.instance?.accessToken {
      self.continuation?.resume(returning: token)
    } else {
      self.continuation?.resume(throwing: MercuryError(from: .ownModule(.naverSignin), .unknown))
    }
    self.continuation = nil
  }
}


extension NaverSignInProvider: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 성공
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    getNaverToken()
  }
  
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    getNaverToken()
  }
  
  func oauth20ConnectionDidFinishDeleteToken() { }
  
  // 로그인 실패
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
    self.continuation?.resume(throwing: error)
    self.continuation = nil
  }
}
