//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

import UIComponent
import AppFoundation
import Domain
import Router

import GoogleSignIn
import GoogleSignInSwift
import KakaoMapsSDK
import NaverThirdPartyLogin
import KakaoSDKCommon

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ToastWindowView {
        AppView()
          .onOpenURL { url in
            GIDSignIn.sharedInstance.handle(url)
          }
      }
    }
  }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    initiateKakaoMapInstance()
    configureGoogleInstance()
    configureNaverLoginInstance()
    configureKakaoLoginInstance()
    
    let container = MercuryContainer.shared
    container.register(SignInTokenInformable.self, instance: SignInInformationManager.shared)
    container.register(SignInUserInformable.self, instance: SignInInformationManager.shared)
    container.register(Toastable.self, instance: MercuryToast.shared)
    
    return true
  }
  
  // MARK: - pre-configure instances
  
  private func initiateKakaoMapInstance() {
    if let sdkAppKey = CommonDefine.mapKey {
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
  }
  
  private func configureGoogleInstance() {
    GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: CommonDefine.googleSignInClientId)
  }
  
  private func configureNaverLoginInstance() {
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    instance?.isNaverAppOauthEnable = true
    instance?.isInAppOauthEnable = true
    instance?.setOnlyPortraitSupportInIphone(false)
    instance?.consumerKey = CommonDefine.naverClientID
    instance?.consumerSecret = CommonDefine.naverClientSecret
    instance?.serviceUrlScheme = Bundle.main.bundleIdentifier
    instance?.appName = "Mercury"
  }
  
  private func configureKakaoLoginInstance() {
    KakaoSDK.initSDK(appKey: CommonDefine.kakaoAuthKey ?? "", loggingEnable: false)
  }
}
