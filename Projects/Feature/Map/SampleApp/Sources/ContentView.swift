//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//

import Map
import SwiftUI

struct ContentView: View {
  
  @State var draw: Bool = true
  
  var body: some View {
    KakaoMapView(draw: $draw)
      .onAppear(perform: {
        self.draw = true
      })
      .frame(maxWidth: .infinity, maxHeight: .infinity)
//      .onDisappear(perform: {
//        self.draw = false
//      })
//      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
}
