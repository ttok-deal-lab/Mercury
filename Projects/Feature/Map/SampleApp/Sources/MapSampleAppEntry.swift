//
//  MapSampleAppEntry.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import SwiftUI

import Map
import KakaoMapsSDK
import AppFoundation
import Coordinator

@main
struct MapSampleAppEntry: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      MapContentView()
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    if let sdkAppKey = CommonDefine.mapKey {
      print(sdkAppKey)
      SDKInitializer.InitSDK(appKey: sdkAppKey)
    }
    return true
  }
}

#Preview {
  MapContentView()
}
