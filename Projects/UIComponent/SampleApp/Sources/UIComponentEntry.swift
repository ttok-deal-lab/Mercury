import SwiftUI
import UIComponent

@main
struct UIComponentEntry: App {
  
  var body: some Scene {
    WindowGroup {
      ScrollView(.vertical) {
        FontTestView()
        Divider()
          .padding(.vertical, 16)
        ColorTestView()
      }
    }
    
  }
}
