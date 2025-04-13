import SwiftUI
import UIComponent

@main
struct UIComponentEntry: App {
  
  var body: some Scene {
    WindowGroup {
      PassthroughWindowView {
      ToastTestView()
      AlertTestView()
        ScrollView(.vertical) {
          FontTestView()
          Divider()
            .padding(.vertical, 16)
          ImageTestView()
          Divider()
            .padding(.vertical, 16)
          ColorTestView()
          Divider()
            .padding(.vertical, 16)
          ShadowTestView()
          Divider()
            .padding(.vertical, 16)
        }
      }
    }
  }
}
