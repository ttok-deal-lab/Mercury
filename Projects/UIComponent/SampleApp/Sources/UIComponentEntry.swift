import SwiftUI

import UIComponent

@main
struct UIComponentEntry: App {
  
  var body: some Scene {
    WindowGroup {
      OverlayWindowView {
        TraySheetTestView()
        ToastTestView()
        AlertTestView()
        LoadingTest()
        ImageChachingView(imageUrl: "https://images.unsplash.com/photo-1515263487990-61b07816b324?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXBhcnRtZW50fGVufDB8fDB8fHww")
        ImageChachingView(imageUrl: "https://plus.unsplash.com/premium_photo-1674676471104-3c4017645e6f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8YXBhcnRtZW50fGVufDB8fDB8fHww")
        ScrollView(.vertical) {
          FontTestView()
          Divider()
            .padding(.vertical, 16)
          ImageTestView()
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
