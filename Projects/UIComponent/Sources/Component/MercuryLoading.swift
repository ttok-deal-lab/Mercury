//
//  MercuryLoading.swift
//  UIComponent
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI

import Lottie

public protocol LoadingPresentable {
  var isLoading: Bool { get }
  func show()
  func hide()
}

@Observable
public final class MercuryLoading: LoadingPresentable {
  public static let shared = MercuryLoading()
  public var isLoading: Bool = false
  
  private init() { }
  
  public func show() {
    self.isLoading = true
  }
  
  public func hide() {
    self.isLoading = false
  }
}

public struct MercuryLoadingView: View {
  private var model = MercuryLoading.shared
  
  private var loadingView: LottieView = LottieView(
    animation: LottieAnimation.named(
      "LoadingAnimation",
      bundle: .module
    )
  )
  
  public var body: some View {
    if model.isLoading {
      loadingView
        .configure { lottieAnimationView in
          lottieAnimationView.contentMode = .scaleAspectFit
          lottieAnimationView.shouldRasterizeWhenIdle = true
          lottieAnimationView.animationSpeed = 6
        }
        .playing(loopMode: .loop)
        .frame(width: 88, height: 88)
    }
  }
}

struct MercuryLoadingModifier: ViewModifier {
  var isLoading: Bool = false
  var loadingView = MercuryLoading.shared
  
  func body(content: Content) -> some View {
    content
      .onDisappear {
        loadingView.hide()
      }
      .onChange(of: isLoading) { oldValue, newValue in
        guard oldValue != newValue else { return }
        if newValue {
          loadingView.show()
        } else {
          loadingView.hide()
        }
      }
  }
}

public extension View {
  func loading(_ isLoading: Bool) -> some View {
    self.modifier(MercuryLoadingModifier(isLoading: isLoading))
  }
}
