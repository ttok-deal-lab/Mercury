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
        Image(.splash)
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
      }
    }
    .ignoresSafeArea()
    .task {
      await versionCheck()
      isSplashDone = true
    }
  }
  
  private func versionCheck() async {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
  }
}
