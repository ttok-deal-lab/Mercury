//
//  CustomSplashModelData.swift
//  CustomSplash
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI
import Combine

import Domain

@Observable
class CustomSplashModelData {
  private var onComplete: () -> Void
  
  init(onComplete: @escaping () -> Void) {
    self.onComplete = onComplete
    
    self.asdf()
  }
  
  private func asdf() {
    Task {
      try? await Task.sleep(for: .seconds(3))
      onComplete()
    }
  }
}


