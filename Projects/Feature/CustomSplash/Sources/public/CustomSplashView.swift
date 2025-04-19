//
//  CustomSplashView.swift
//  MercuryApp
//
//  Created by 최수훈 on 4/14/25.
//

import SwiftUI

import UIComponent

public struct CustomSplashView: View {
  @State private var modelData: CustomSplashModelData
  
  public init(onComplete: @escaping () -> Void) {
    self.modelData = CustomSplashModelData(onComplete: onComplete)
  }
  
  public var body: some View {
    ZStack {
      GeometryReader { geometry in
        Asset.splash.image
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
      }
    }
    .ignoresSafeArea()
  }
}
