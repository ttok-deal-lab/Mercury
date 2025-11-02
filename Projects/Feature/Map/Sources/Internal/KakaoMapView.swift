//
//  KakaoMapView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import AppFoundation
import Foundation
import SwiftUI
import CoreLocation
import KakaoMapsSDK
import KakaoMapsSDK_SPM

public struct KakaoMapView: UIViewRepresentable {
  
  // MARK: - private property
  
  // MARK: - public property
  
  @Binding public var draw: Bool
  @Binding public var cameraCenterLocation: CLLocationCoordinate2D
  
  
  // MARK: - life cycle

  public init(
    draw: Binding<Bool>,
    cameraCenterLocation: Binding<CLLocationCoordinate2D>
  ) {
    self._draw = draw
    self._cameraCenterLocation = cameraCenterLocation
  }
  
  
  // MARK: - public method
  
  public func makeUIView(context: Self.Context) -> KMViewContainer {
    let view: KMViewContainer = KMViewContainer()
    view.sizeToFit()
    context.coordinator.createController(view)
    return view
  }
  
  public func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { // 타이밍 이슈로 넣음.
      if draw {
        context.coordinator.controller?.activateEngine()
        onMapFullyLoaded(context: context)
      } else {
        context.coordinator.controller?.resetEngine()
      }
    })
  }
  
  public static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
    coordinator.controller?.pauseEngine()
    coordinator.controller?.resetEngine()
  }
  
  
  // MARK: - private method
  
  private func onMapFullyLoaded(context: Self.Context) {
    context.coordinator.setCameraFirst(location: cameraCenterLocation)
  }
  
  public func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator(
      parent: self,
      longitude: cameraCenterLocation.longitude,
      latitude: cameraCenterLocation.latitude
    )
  }

  
}
