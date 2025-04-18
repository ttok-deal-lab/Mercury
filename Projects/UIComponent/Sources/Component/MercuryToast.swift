//
//  MercuryToast.swift
//  UIComponent
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import UIKit

public protocol Toastable {
  func present(title: String, tint: Color, timing: ToastTime)
}

struct ToastInformation: Identifiable {
  public let id: UUID = .init()
  var title: String
  var tint: Color
  var timing: ToastTime = .medium
  
  public init(title: String, tint: Color, timing: ToastTime) {
    self.title = title
    self.tint = tint
    self.timing = timing
  }
}

public enum ToastTime: CGFloat {
  case short = 1.0
  case medium = 2.0
  case long = 3.5
}

@Observable
public final class MercuryToast: Toastable {
  public static let shared = MercuryToast()
  fileprivate var toasts: [ToastInformation] = []
  
  public func present(
    title: String,
    tint: Color = Asset.Colors.gray900TextBlack.color,
    timing: ToastTime = .long
  ) {
    withAnimation(.snappy) {
      toasts
        .append(
          .init(
            title: title,
            tint: tint,
            timing: timing
          )
        )
    }
  }
}

struct ToastGroup: View {
  var model = MercuryToast.shared
  var body: some View {
    GeometryReader {
      let size = $0.size
      let safeArea = $0.safeAreaInsets
      
      ZStack {
        ForEach(model.toasts) { toast in
          ToastView(size: size, item: toast)
            .scaleEffect(scale(item: toast))
            .offset(y: offsetY(item: toast))
        }
      }
      .padding(.bottom, safeArea.top == .zero ? 15 : 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
  }
  
  func offsetY(item: ToastInformation) -> CGFloat {
    let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
    let totalCount = CGFloat(model.toasts.count) - 1
    return (totalCount - index) >= 2 ? -20 : ((totalCount - index) * -10)
  }
  
  func scale(item: ToastInformation) -> CGFloat {
    let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
    let totalCount = CGFloat(model.toasts.count) - 1
    return 1.0 - ((totalCount - index) >= 2 ? 0.2 : ((totalCount - index) * 0.1))
  }
}

fileprivate struct ToastView: View {
  var size: CGSize
  var item: ToastInformation
  @State private var animateIn: Bool = false
  @State private var animateOut: Bool = false
  
  var body: some View {
    HStack(spacing: .zero) {
      Text(item.title)
        .lineLimit(1)
    }
    .foregroundStyle(item.tint)
    .padding(.horizontal, 15)
    .padding(.vertical, 8)
    .background(
      .background
        .shadow(.drop(color: .primary.opacity(0.1), radius: 11, x: 0, y: 3)),
      in: .capsule
    )
    .contentShape(.capsule)
    .offset(y: animateIn ? 10 : -150)
    .offset(y: !animateOut ? 10 : -150)
    .task {
      guard !animateIn else { return }
      withAnimation(.snappy) {
        animateIn = true
      }
      try? await Task.sleep(for: .seconds(item.timing.rawValue))
      
      removeToast()
    }
    .frame(maxWidth: size.width * 0.7)
  }

  func removeToast() {
    guard !animateOut else { return }
    withAnimation(.snappy, completionCriteria: .logicallyComplete) {
      animateOut = true
    } completion: {
      removeToastItem()
    }
  }
  
  func removeToastItem() {
    MercuryToast.shared.toasts.removeAll(where: { $0.id == item.id })
  }
}
