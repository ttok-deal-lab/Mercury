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

  
  // MARK: - Coordinator
  
  public class KakaoMapCoordinator: NSObject, MapControllerDelegate, @preconcurrency KakaoMapEventDelegate {
    
    // MARK: - private property
    
    private let parent: KakaoMapView
    
    private var isFirstEntry: Bool = true
    private var isMapReady: Bool = false
    private var pendingCameraUpdate: (() -> Void)?
    private var kakaoMap: KakaoMap?
    
    // MARK: - internal property
    
    var controller: KMController?
    
    
    // MARK: - life cycle
    
    public init(parent: KakaoMapView) {
      self.parent = parent
      super.init()
    }
    
    
    // MARK: - private method
    
    private func setup() {
      if let pendingCameraUpdate {
        pendingCameraUpdate()
        self.pendingCameraUpdate = nil
      }
      self.kakaoMap?.eventDelegate = self
    }
    
    
    // MARK: - public method
    
    public func setCameraFirst(location: CLLocationCoordinate2D) {
      guard isFirstEntry else { return }
      let updateCamera = {
        guard let kakaoMap = self.kakaoMap else { return }
        let firstMapPoint = MapPoint(longitude: location.longitude, latitude: location.latitude)
        let cameraUpdate = CameraUpdate.make(target: firstMapPoint, mapView: kakaoMap)
        kakaoMap.moveCamera(cameraUpdate)
      }
      if isMapReady {
        updateCamera()
        self.isFirstEntry = false
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
    
    @MainActor
    @objc public func cameraDidStopped(kakaoMap: KakaoMap, by: MoveBy) {
      let position = kakaoMap.getPosition(.init(x: 0.5, y: 0.5))
      let centerCoord = CLLocationCoordinate2D(
        latitude: position.wgsCoord.latitude,
        longitude: position.wgsCoord.longitude
      )
      self.parent.cameraCenterLocation = centerCoord
    }
  }
  
  
}
