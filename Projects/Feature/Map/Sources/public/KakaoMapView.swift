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
  
  // MARK: - private property
  
  
  
  // MARK: - public property
  
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
    if let userLocation {
      context.coordinator.setLocationForCamera(location: userLocation)
    }
  }
  
  public func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator()
  }

  
  // MARK: - Coordinator
  
  public class KakaoMapCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate {
    
    // MARK: - private property
    
    private var isFirstEntry: Bool
    private var isMapReady: Bool = false
    private var pendingCameraUpdate: (() -> Void)?
    private var kakaoMap: KakaoMap?
    
    // MARK: - internal property
    
    var controller: KMController?
    
    
    // MARK: - life cycle
    
    public override init() {
      self.isFirstEntry = true
      super.init()
    }
    
    
    // MARK: - private method
    
    private func setup() {
      if let pendingCameraUpdate {
        pendingCameraUpdate()
        self.pendingCameraUpdate = nil
      }
    }
    
    
    // MARK: - public method
    
    public func setLocationForCamera(location: CLLocationCoordinate2D) {
      let updateCamera = {
        guard let kakaoMap = self.kakaoMap else { return }
        let firstMapPoint = MapPoint(longitude: location.longitude, latitude: location.latitude)
        let cameraUpdate = CameraUpdate.make(target: firstMapPoint, mapView: kakaoMap)
        kakaoMap.moveCamera(cameraUpdate)
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
      let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001) // 초기 좌표
      let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
      
      controller?.addView(mapviewInfo)
    }
    
    public func addViewSucceeded(_ viewName: String, viewInfoName: String) {
      self.isMapReady = true
      self.kakaoMap = self.controller?.getView(viewName) as? KakaoMap
      self.setup()
    }
    
  }
  
  
}
