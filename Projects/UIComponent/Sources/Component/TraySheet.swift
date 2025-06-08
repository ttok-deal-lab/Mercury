//
//  BottomSheet.swift
//  UIComponent
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI

public struct TrayConfig {
  public var maxDetent: PresentationDetent
  public var cornerRadius: CGFloat
  public var isInteractiveDismissDisabled: Bool
  public var horizontalPadding: CGFloat
  public var bottomPadding: CGFloat
  
  public init(
    maxDetent: PresentationDetent,
    cornerRadius: CGFloat = 30,
    isInteractiveDismissDisabled: Bool = false,
    horizontalPadding: CGFloat = 15,
    bottomPadding: CGFloat = 15
  ) {
    self.maxDetent = maxDetent
    self.cornerRadius = cornerRadius
    self.isInteractiveDismissDisabled = isInteractiveDismissDisabled
    self.horizontalPadding = horizontalPadding
    self.bottomPadding = bottomPadding
  }
}

public extension View {
  func traySheet<Content: View>(
    isPresented: Binding<Bool>,
    config: TrayConfig = .init(maxDetent: .fraction(0.99)),
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    self
      .sheet(isPresented: isPresented) {
        content()
          .frame(maxWidth: .infinity)
          .background(.background)
          .clipShape(.rect(cornerRadius: config.cornerRadius))
          .padding(.horizontal, config.horizontalPadding)
          .padding(.bottom, config.bottomPadding)
          .frame(maxHeight: .infinity, alignment: .bottom)
          .presentationDetents([config.maxDetent])
          .presentationCornerRadius(0)
          .presentationBackground(.clear)
          .presentationDragIndicator(.hidden)
          .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
          .background(RemoveSheetShadow())
      }
  }
}

struct RemoveSheetShadow: UIViewRepresentable {
  func makeUIView(context: Context) -> some UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    
    DispatchQueue.main.async {
      if let shadowView = view.dropShadowView {
        shadowView.layer.shadowColor = UIColor.clear.cgColor
      }
    }
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
}

extension UIView {
  var dropShadowView: UIView? {
    if let superview, String(describing: type(of: superview)) == "UIDropShadowView" {
      return superview
    }
    return superview?.dropShadowView
  }
}
