//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

import AppFoundation
import Coordinator

import GoogleSignIn
import KakaoMapsSDK
import NaverThirdPartyLogin

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      AppView()
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
    }
  }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    if let sdkAppKey = CommonDefine.mapKey {
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
    
    // naver SignIn
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    instance?.isNaverAppOauthEnable = true  // 네이버 앱으로 인증하는 방식 활성화(true)
    instance?.isInAppOauthEnable = true    // SafariViewContoller에서 인증하는 방식 활성화(true)
    instance?.setOnlyPortraitSupportInIphone(false)  // 네이버 로그인 가로모드 고정
    instance?.consumerKey = CommonDefine.naverClientID
    instance?.consumerSecret = CommonDefine.naverClientSecret
    instance?.serviceUrlScheme = Bundle.main.bundleIdentifier
    instance?.appName = "Mercury"
    
    let container = MercuryContainer.shared
    container.register(SignInTokenInformable.self, instance: SignInInformationManager.shared)
    container.register(SignInUserInformable.self, instance: SignInInformationManager.shared)
    
    return true
  }
}
