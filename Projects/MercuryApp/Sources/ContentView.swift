//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import Map

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
