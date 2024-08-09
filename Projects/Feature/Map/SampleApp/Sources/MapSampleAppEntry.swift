//
//  MapSampleAppEntry.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import Map
import SwiftUI
import KakaoMapsSDK
import AppFoundation

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
    
    if let sdkAppKey = CommonDefine.mapKey {
      print("sdk app key -> \(sdkAppKey)")
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
    return true
  }
}

