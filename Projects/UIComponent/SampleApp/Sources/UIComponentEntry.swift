import SwiftUI

import UIComponent

@main
struct UIComponentEntry: App {
  
  @State var memoryImageUrl = ""
  var body: some Scene {
    WindowGroup {
      OverlayWindowView {
        TraySheetTestView()
        ToastTestView()
        AlertTestView()
        LoadingTest()
        Button("memoryImageTest") {
          memoryImageUrl = "https://images.unsplash.com/photo-1740609472416-725ff118140d?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGFwYXJ0fGVufDB8fDB8fHww"
        }
        ImageCachingView(imageUrl: "https://images.unsplash.com/photo-1740609472416-725ff118140d?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGFwYXJ0fGVufDB8fDB8fHww")
        // 두 번째 이미지 - 버튼 누르면 메모리 캐시에서 로드
        if memoryImageUrl.isEmpty {
          Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 100, height: 150)
            .overlay(Text("버튼을 눌러주세요"))
        } else {
          ImageCachingView(imageUrl: memoryImageUrl)
        }
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
