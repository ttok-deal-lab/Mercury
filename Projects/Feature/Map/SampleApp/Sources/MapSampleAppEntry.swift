//
//  MapSampleAppEntry.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import Map
import SwiftUI
import KakaoMapsSDK
import KakaoMapsSDK_SPM

@main
struct MapSampleAppEntry: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

struct ContentView: View {
  @State var draw: Bool = false
  var body: some View {
    KakaoMapView(draw: $draw).onAppear(perform: {
      self.draw = true
    }).onDisappear(perform: {
      self.draw = false
    }).frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
