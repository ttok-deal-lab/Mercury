//
//  KakaoMapView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import Foundation
import SwiftUI
import CoreLocation
import KakaoMapsSDK

@MainActor public struct KakaoMapView: UIViewRepresentable {
  
  // MARK: - private property
  
  
  
  // MARK: - public property
  
  @Binding public var draw: Bool
  public var userLocation: CLLocationCoordinate2D?
  @Binding public var cameraCenterLocation: CLLocationCoordinate2D?
  
  
  // MARK: - life cycle

  public init(draw: Binding<Bool>, userLocation: CLLocationCoordinate2D?, cameraCenterLocation: Binding<CLLocationCoordinate2D?>) {
    self._draw = draw
    self.userLocation = userLocation
    self._cameraCenterLocation = cameraCenterLocation
  }
  
  
  // MARK: - public method

  public func makeUIView(context: Self.Context) -> KMViewContainer {
    let view: KMViewContainer = KMViewContainer()
    view.sizeToFit()
    context.coordinator.createController(view)
    context.coordinator.controller?.prepareEngine()
    return view
  }
  
  public func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { // 타이밍 이슈로 넣음.
      if draw {
        context.coordinator.controller?.activateEngine()
        onMapFullyLoaded(context: context)
      } else {
        context.coordinator.controller?.resetEngine()
      }
    })
  }
  
  private func onMapFullyLoaded(context: Self.Context) {
    if let userLocation {
      context.coordinator.setCameraFirst(location: userLocation)
    }
  }
  
  public func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator(parent: self)
  }

  
}
