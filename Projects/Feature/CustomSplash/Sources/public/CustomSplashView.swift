//
//  CustomSplashView.swift
//  MercuryApp
//
//  Created by 최수훈 on 4/14/25.
//

import SwiftUI

import UIComponent
import Domain

public struct CustomSplashView: View {
  @State private var modelData: CustomSplashModelData
  
  public init(onComplete: @escaping (Bool) -> Void, localStorageUsecasable: LocalStorageUsecasable) {
    self.modelData = CustomSplashModelData(onComplete: onComplete, localStorageUsecasable: localStorageUsecasable)
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
