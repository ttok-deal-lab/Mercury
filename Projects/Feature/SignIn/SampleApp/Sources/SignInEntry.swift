import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@main
struct SignInEntry: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
    }
  }
}

