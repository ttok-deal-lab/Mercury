import SwiftUI
import SwiftData

import AppFoundation

import Infrastructure

import GoogleSignIn
import GoogleSignInSwift
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct SignInEntry: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
          if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
          }
        }
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    
    // naver SignIn
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    instance?.isNaverAppOauthEnable = true  // 네이버 앱으로 인증하는 방식 활성화(true)
    instance?.isInAppOauthEnable = true    // SafariViewContoller에서 인증하는 방식 활성화(true)
    instance?.setOnlyPortraitSupportInIphone(false)  // 네이버 로그인 가로모드 고정
    instance?.consumerKey = CommonDefine.naverClientID
    instance?.consumerSecret = CommonDefine.naverClientSecret
    instance?.serviceUrlScheme = Bundle.main.bundleIdentifier
    instance?.appName = "Mercury"
    
    // KakaoAuth
    var kakaoAuthKey = CommonDefine.kakaoAuthKey
    debugPrint("kakaoAuthKey: \(kakaoAuthKey)")
    KakaoSDK.initSDK(appKey: CommonDefine.kakaoAuthKey ?? "")
    return true
  }
}
