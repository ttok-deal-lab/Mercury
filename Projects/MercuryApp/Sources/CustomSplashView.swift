//
//  CustomSplashView.swift
//  MercuryApp
//
//  Created by 최수훈 on 4/14/25.
//

import SwiftUI

struct CustomSplashView: View {
  
  @Binding var isSplashDone: Bool
  
  var body: some View {
    ZStack {
      GeometryReader { geometry in
        Image("splash")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
      }
    }
    .ignoresSafeArea()
    .task {
      try? await Task.sleep(nanoseconds: 5_000_000_000)
           isSplashDone = true
    }
  }
}
