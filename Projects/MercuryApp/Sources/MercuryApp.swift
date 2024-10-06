//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import AppFoundation
import SwiftData

import KakaoMapsSDK
import Coordinator
import GoogleSignIn
import GoogleSignInSwift
import Map

@main
struct MercuryApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
//  let container: ModelContainer
  
  init() {
//    do {
//      let config = ModelConfiguration(isStoredInMemoryOnly: false)
//      container = try ModelContainer(for: Filter.self, configurations: config)
//    } catch {
//      fatalError("Failed to initialize ModelContainer: \(error)")
//    }
  }
  
  var body: some Scene {
    WindowGroup {
      AppView()
//        .modelContainer(container)
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
    return true
  }
}
