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

@main
struct MercuryApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @StateObject var coordinator = CoordinatorManager()
  
  var body: some Scene {
    WindowGroup {
      AppView()
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
    }
    .environmentObject(coordinator)
    .modelContainer(for: Filter.self)
  }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    
    if let sdkAppKey = CommonDefine.mapKey {
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
    return true
  }
}
