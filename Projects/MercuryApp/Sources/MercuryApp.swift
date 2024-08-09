//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import AppFoundation
import KakaoMapsSDK

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .ignoresSafeArea()
    }
  }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    
    if let sdkAppKey = CommonDefine.mapKey {
      print("sdk app key -> \(sdkAppKey)")
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
    return true
  }
}