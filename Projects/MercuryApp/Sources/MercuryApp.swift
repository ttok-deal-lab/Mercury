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
import Onboard

import GoogleSignIn
import GoogleSignInSwift
import KakaoMapsSDK
import NidThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import FirebaseAnalytics
import FirebaseMessaging
import Pulse
import PulseProxy
import PulseUI

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      OverlayWindowView {
        MainView()
          .environment(NetworkMonitor.shared)
          .onOpenURL { url in
            OauthDeepLinkHandler.shared.handle(url: url)
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
    configureNetworkLogger()
    
    let container = MercuryContainer.shared
    container.register(SignInInformationReadable.self, instance: SignInInformationManager.shared)
    container.register(AccessTokenManagable.self, instance: SignInInformationManager.shared)
    container.register(UserInfoManagable.self, instance: SignInInformationManager.shared)
    container.register(Toastable.self, instance: MercuryToast.shared)
    container.register(Alertable.self, instance: MercuryAlert.shared)
    container.register(LoadingPresentable.self, instance: MercuryLoading.shared)
    
    DispatchQueue.main.async {
      let appearance = UITabBarAppearance.blurredSafe()
      
      UITabBar.appearance().standardAppearance = appearance
      UITabBar.appearance().scrollEdgeAppearance = appearance
      UITabBar.appearance().isTranslucent = true
    }
    
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
    NidOAuth.shared
      .initialize(
        appName: CommonDefine.naverAppName ?? "",
        clientId: CommonDefine.naverClientID ?? "",
        clientSecret: CommonDefine.naverClientSecret ?? "",
        urlScheme: CommonDefine.naverURLScheme ?? ""
      )
  }
  
  private func configureKakaoLoginInstance() {
    KakaoSDK.initSDK(appKey: CommonDefine.kakaoAuthKey ?? "", loggingEnable: false)
  }
  
  private func configFirebase(_ application: UIApplication) {
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    
    UNUserNotificationCenter.current().delegate = self
    application.registerForRemoteNotifications()
  }
  
  private func configureNetworkLogger() {
    URLSessionProxyDelegate.enableAutomaticRegistration()
    NetworkLogger.enableProxy()
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

extension UITabBarAppearance {
  static func blurredSafe() -> UITabBarAppearance {
    let appearance = UITabBarAppearance()
    appearance.configureWithDefaultBackground()
    appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
    appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
    appearance.shadowColor = .clear
    return appearance
  }
}
