
import Foundation
import AppFoundation
import NaverThirdPartyLogin

@MainActor
class NaverSignInProvider: NSObject, UIApplicationDelegate,  SignInable {
  
  // MARK: - private property
  private let instance = NaverThirdPartyLoginConnection.getSharedInstance()
  // MARK: - internal method
  func configure() {
    
  }
  
  // TODO: - 최초 1회만 하면 되는건가?
  public func configure(clientId: String, clientSecret: String, appName: String) {
    instance?.isNaverAppOauthEnable = true  // 네이버 앱으로 인증하는 방식 활성화(true)
    instance?.isInAppOauthEnable = true    // SafariViewContoller에서 인증하는 방식 활성화(true)
    instance?.setOnlyPortraitSupportInIphone(true)  // 네이버 로그인 가로모드 고정
    instance?.consumerKey = "_WPqt4ptaBS2GqSjS9WK"
    instance?.consumerSecret = "S45_aD4cZS"
    instance?.serviceUrlScheme = "com.auction.mercury.SignInSampleApp"
    instance?.appName = "Mercury"
  }
  
  public func login() {
    
    instance?.requestThirdPartyLogin() // 토큰 요청
  }
  
  public func logout() {
    instance?.requestDeleteToken()
  }
  
  func signIn() async throws -> OauthSignInToken {
    guard let instancce = instance else {
      throw MercuryError(from: .ownModule(.naverSignin), .unknown)
    }
    
    return try await withCheckedContinuation { continuation in
      instance?.delegate = self
      instance?.requestThirdPartyLogin()
      
      // 비동기 처리 후 결과전달
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        if let token = self.instance?.accessToken {
          continuation.resume(returning: token)
        } else {
          continuation.resume(throwing: MercuryError(from: .ownModule(.naverSignin), .unknown) as! Never)
          return
        }
      }
    } // return
  }
}


extension NaverSignInProvider: NaverThirdPartyLoginConnectionDelegate {
  
  
  // 로그인 성공
  nonisolated func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print(#function)
  }
  
  nonisolated func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    print(#function)
  }
  
  nonisolated func oauth20ConnectionDidFinishDeleteToken() {
    print(#function)
  }
  
  // 로그인 실패
  nonisolated func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
    print(#function)
  }
  
  
  
}
