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
import FirebaseCore
import FirebaseAnalytics
import FirebaseMessaging
import Pulse
import PulseUI

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      OverlayWindowView {
        MainView()
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
    
    configFirebase(application)
    
    URLSessionProxyDelegate.enableAutomaticRegistration()
    
    let container = MercuryContainer.shared
    container.register(SignInInformationReadable.self, instance: SignInInformationManager.shared)
    container.register(AccessTokenManagable.self, instance: SignInInformationManager.shared)
    container.register(UserInfoManagable.self, instance: SignInInformationManager.shared)
    container.register(Toastable.self, instance: MercuryToast.shared)
    container.register(Alertable.self, instance: MercuryAlert.shared)
    container.register(LoadingPresentable.self, instance: MercuryLoading.shared)
    
    return true
  }
}

extension AppDelegate { // pre-configure instances
  
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
  
  private func configFirebase(_ application: UIApplication) {
    
    FirebaseApp.configure()
    
    Messaging.messaging().delegate = self
    
    UNUserNotificationCenter.current().delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, _ in
      if granted {
        print("알림 등록이 완료되었습니다.")
      }
    }
    application.registerForRemoteNotifications()
  }
  
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound, .badge])
  }
}

extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    SignInInformationManager.shared.setFcmToken(fcmToken)
  }
}
