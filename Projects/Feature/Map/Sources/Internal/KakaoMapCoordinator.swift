//
//  KakaoMapCoordinator.swift
//  Map
//
//  Created by 송하민 on 8/14/24.
//

import Foundation
import KakaoMapsSDK
import CoreLocation

public class KakaoMapCoordinator: NSObject, MapControllerDelegate {
  
  // MARK: - private property
  
  private let parent: KakaoMapView
  
  private var isFirstEntry: Bool = true
  private var isMapReady: Bool = false
  private var pendingCameraUpdate: (() -> Void)?
  private var kakaoMap: KakaoMap?
  
  // MARK: - public property
  
  public var controller: KMController?
  
  
  // MARK: - life cycle
  
  public init(parent: KakaoMapView) {
    self.parent = parent
    super.init()
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

 
}

extension KakaoMapCoordinator: @preconcurrency KakaoMapEventDelegate {
  
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
