import SwiftUI
import Foundation

import AppFoundation

@main
struct AppFoundationEntry: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    MercuryContainer.shared.register(MockLoggerProtocol.self, instance: MockLoggerConcrete())
    return true
  }
}

protocol MockLoggerProtocol {
  func log()
}

final class MockLoggerConcrete: MockLoggerProtocol {
  func log() {
    print("I'm logging")
  }
}
