import SwiftUI

import Coordinator

@main
struct AuctionEntry: App {
  
  @StateObject var coordinator = CoordinatorManager()
  var body: some Scene {
    WindowGroup {
        ContentView()
        .environmentObject(coordinator)
    }
  }
}
