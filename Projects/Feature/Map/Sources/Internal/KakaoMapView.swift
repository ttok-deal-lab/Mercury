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

@MainActor public struct KakaoMapView: UIViewRepresentable {
  
  // MARK: - private property
  
  // MARK: - public property
  
  @Binding public var draw: Bool
  public var userLocation: CLLocationCoordinate2D?
  @Binding public var cameraCenterLocation: CLLocationCoordinate2D?
//  public var auctionItems: [AuctionItem]?
  
  
  // MARK: - life cycle

  public init(
    draw: Binding<Bool>,
    userLocation: CLLocationCoordinate2D?,
    cameraCenterLocation: Binding<CLLocationCoordinate2D?>
//    auctionItems: [AuctionItem]?
  ) {
    self._draw = draw
    self.userLocation = userLocation
    self._cameraCenterLocation = cameraCenterLocation
//    self.auctionItems = auctionItems
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
    if let userLocation {
      context.coordinator.setCameraFirst(location: userLocation)
    }
//    if let auctionItems {
//      context.coordinator.drawItemMarker(item: auctionItems)
//    }
  }
  
  public func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator(parent: self)
  }

  
}
