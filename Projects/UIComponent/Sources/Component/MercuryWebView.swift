//
//  MercuryWebView.swift
//  UIComponent
//
//  Created by 최수훈 on 12/15/25.
//

import SwiftUI
import WebKit

public struct MercuryWebView: UIViewRepresentable {
  public var url: URL
  @Binding public var isLoading: Bool
  
  public init(url: URL, isLoading: Binding<Bool>) {
    self.url = url
    self._isLoading = isLoading
  }
  
  public func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    let configuration = WKWebViewConfiguration()
    let webView = WKWebView(frame: .zero, configuration: configuration)
    let request = URLRequest(url: url)
    webView.load(request)
    
    return webView
  }
  
  public func updateUIView(_ uiView: UIViewType, context: Context) {
    return
  }
  
  public class Coordinator: NSObject, WKNavigationDelegate {
    private let parent: MercuryWebView
    
    init(parent: MercuryWebView) {
      self.parent = parent
    }
  }
  
}
