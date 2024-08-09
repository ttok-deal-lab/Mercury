//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//

import Map
import SwiftUI

struct ContentView: View {
  
  @State var draw: Bool = false
  
  var body: some View {
    KakaoMapView(draw: $draw)
      .onAppear(perform: {
        self.draw = true
      })
      .onDisappear(perform: {
        self.draw = false
      })
  }
  
}
