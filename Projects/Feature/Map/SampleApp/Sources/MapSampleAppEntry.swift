//
//  MapSampleAppEntry.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import Map
import SwiftUI
import KakaoMapsSDK

@main
struct MapSampleAppEntry: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    if let sdkAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_MAP_KEY") as? String {
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
    return true
  }
}

