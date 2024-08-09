//
//  KakaoMapView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import Foundation
import SwiftUI
import KakaoMapsSDK
import KakaoMapsSDK_SPM

@MainActor public struct KakaoMapView: UIViewRepresentable {
  @Binding public var draw: Bool
  
  
  // MARK: - life cycle

  public init(draw: Binding<Bool>) {
    self._draw = draw
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
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { // 타이밍 이슈로 넣음.
      context.coordinator.controller?.activateEngine()
    })
  }
  
  public func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator()
  }
  
  public class KakaoMapCoordinator: NSObject, MapControllerDelegate {
    
    public override init() {
      first = true
      super.init()
    }
    
    public func createController(_ view: KMViewContainer) {
      controller = KMController(viewContainer: view)
      controller?.delegate = self
    }
    
    @objc public func addViews() {
      let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
      let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
      
      controller?.addView(mapviewInfo)
    }
    
    @objc public func containerDidResized(_ size: CGSize) {
      let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
      mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
      if first {
        let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: 14135167.020272, latitude: 4518393.389136), zoomLevel: 10, mapView: mapView!)
        mapView?.moveCamera(cameraUpdate)
        first = false
      }
    }
    
    var controller: KMController?
    var first: Bool
  }
}
