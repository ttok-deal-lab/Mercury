//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

import AppFoundation
import Router

import KakaoMapsSDK
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      AppView()
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
    instance?.isNaverAppOauthEnable = true
    instance?.isInAppOauthEnable = true
    instance?.setOnlyPortraitSupportInIphone(false)
    instance?.consumerKey = CommonDefine.naverClientID
    instance?.consumerSecret = CommonDefine.naverClientSecret
    instance?.serviceUrlScheme = Bundle.main.bundleIdentifier
    instance?.appName = "Mercury"
    
    let container = MercuryContainer.shared
    container.register(SignInTokenInformable.self, instance: SignInInformationManager.shared)
    container.register(SignInUserInformable.self, instance: SignInInformationManager.shared)
    
    // Kakao SignIn
    KakaoSDK.initSDK(appKey: CommonDefine.kakaoAuthKey ?? "")
    
    return true
  }
}
