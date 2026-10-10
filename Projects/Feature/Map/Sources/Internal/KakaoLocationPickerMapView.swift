//
//  KakaoLocationPickerMapView.swift
//  Map
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI
import CoreLocation
import KakaoMapsSDK
import KakaoMapsSDK_SPM

/// 위치 선택용 카카오맵. 고정 핀(POI) 없이 카메라만 움직이고, 멈출 때 화면 중앙 좌표를 알려준다.
struct KakaoLocationPickerMapView: UIViewRepresentable {
  let initialCoordinate: CLLocationCoordinate2D
  let moveRequest: LocationPickerCameraTarget?
  let onCenterChanged: (CLLocationCoordinate2D) -> Void
  let onMoveStarted: () -> Void
  
  func makeUIView(context: Context) -> KMViewContainer {
    let view = KMViewContainer()
    view.sizeToFit()
    context.coordinator.createController(view)
    return view
  }
  
  func updateUIView(_ uiView: KMViewContainer, context: Context) {
    context.coordinator.parent = self
    if let moveRequest, moveRequest.id != context.coordinator.lastMoveRequestID {
      context.coordinator.lastMoveRequestID = moveRequest.id
      context.coordinator.moveCamera(to: moveRequest.coordinate)
    }
  }
  
  static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoLocationPickerCoordinator) {
    coordinator.controller?.pauseEngine()
    coordinator.controller?.resetEngine()
  }
  
  func makeCoordinator() -> KakaoLocationPickerCoordinator {
    KakaoLocationPickerCoordinator(parent: self)
  }
}
