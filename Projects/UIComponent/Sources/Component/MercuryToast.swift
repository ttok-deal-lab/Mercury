//
//  MercuryToast.swift
//  UIComponent
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import UIKit
import Combine

import AppFoundation

public protocol Toastable {
  func present(title: String, toastType: ToastType, timing: ToastTime)
}

struct ToastInformation: Identifiable {
  public let id: UUID = .init()
  var title: String
  var toastType: ToastType
  var timing: ToastTime = .medium
  
  public init(title: String, toastType: ToastType, timing: ToastTime) {
    self.title = title
    self.toastType = toastType
    self.timing = timing
  }
}

public enum ToastTime: CGFloat {
  case short = 1.0
  case medium = 2.0
  case long = 3.5
}

public enum ToastType {
  case common
  case urgent
}


@Observable
public final class MercuryToast: Toastable {
  public static let shared = MercuryToast()
  fileprivate var toasts: [ToastInformation] = []
  
  public func present(
    title: String,
    toastType: ToastType,
    timing: ToastTime = .long
  ) {
    withAnimation(.snappy) {
      toasts
        .append(
          .init(
            title: title,
            toastType: toastType,
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
      Label {
        Text(item.title)
          .lineLimit(1)
      } icon: {
        toastIcon(toastType: item.toastType)
      }
      Spacer()
    }
    .foregroundStyle(.white)
    .padding(.horizontal, 15)
    .padding(.bottom, 14)
    .padding(.top, 12)
    .background(
      Asset.Colors.gray600.color,
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
    .frame(maxWidth: size.width * 0.9)
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
  
  private func toastIcon(toastType: ToastType) -> some View {
    switch toastType {
    case .common:
      Asset.Images.toastCommon.image
    case .urgent:
      Asset.Images.toastUrgent.image
    }
  }
   
}

struct MercuryToastModifier: ViewModifier {
  @Inject private var toast: Toastable
  let isPresented: Bool
  let text: String
  let toastType: ToastType
  let timing: ToastTime
  
  init(
    isPresented: Bool,
    text: String,
    toastType: ToastType,
    timing: ToastTime
  ) {
    self.isPresented = isPresented
    self.text = text
    self.toastType = toastType
    self.timing = timing
  }
  
  func body(content: Content) -> some View {
    return content
      .onReceive(Just(isPresented)) { _ in
        toast.present(title: text, toastType: toastType, timing: timing)
      }
  }
}

public extension View {
  func toast(
    isPresented: Bool,
    text: String,
    toastType: ToastType = .common,
    timing: ToastTime = .medium
  ) -> some View {
    modifier(
      MercuryToastModifier(
        isPresented: isPresented,
        text: text,
        toastType: toastType,
        timing: timing
      )
    )
  }
}

