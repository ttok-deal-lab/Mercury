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
import KakaoMapsSDK_SPM

@MainActor public struct KakaoMapView: UIViewRepresentable {
  @Binding public var draw: Bool
  @Binding public var userLocation: CLLocationCoordinate2D?
  
  // MARK: - life cycle

  public init(draw: Binding<Bool>, userLocation: Binding<CLLocationCoordinate2D?>) {
    self._draw = draw
    self._userLocation = userLocation
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
    print("user location ~> \(String(describing: userLocation))")
    if let userLocation {
      context.coordinator.setLocationForCamera(location: userLocation)
    }
  }
  
  public func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator()
  }
  
  public class KakaoMapCoordinator: NSObject, MapControllerDelegate {
    
    var controller: KMController?
    var first: Bool
    var isMapReady: Bool = false
    var pendingCameraUpdate: (() -> Void)?
    
    
    // MARK: - life cycle
    
    public override init() {
      first = true
      super.init()
    }
    
    
    // MARK: - internal method
    
    // MARK: - public method
    
    public func setLocationForCamera(location: CLLocationCoordinate2D) {
      let updateCamera = {
        if let mapView: KakaoMap = self.controller?.getView("mapview") as? KakaoMap {
          let cameraUpdate = CameraUpdate.make(
            target: MapPoint(
              longitude: location.longitude,
              latitude: location.latitude
            ),
            mapView: mapView
          )
          mapView.moveCamera(cameraUpdate)
        }
      }
      if isMapReady {
        updateCamera()
      } else {
        self.pendingCameraUpdate = updateCamera
      }
      
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
    
    public func addViewSucceeded(_ viewName: String, viewInfoName: String) {
      self.isMapReady = true
      if let pendingCameraUpdate {
        pendingCameraUpdate()
        self.pendingCameraUpdate = nil
      }
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
   
  }
}
