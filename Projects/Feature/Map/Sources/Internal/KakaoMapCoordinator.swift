//
//  KakaoMapCoordinator.swift
//  Map
//
//  Created by 송하민 on 8/14/24.
//

import AppFoundation
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
    controller?.prepareEngine()
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
    self.createLabelLayer()
  }
  
  private func createLabelLayer() {
    guard let kakaoMap else { return }
    let manager = kakaoMap.getLabelManager()
    let layerOption = LabelLayerOptions(
      layerID: "PoiLayer",
      competitionType: .none,
      competitionUnit: .symbolFirst,
      orderType: .rank,
      zOrder: 1
    )
    let _ = manager.addLabelLayer(option: layerOption)
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
  
  public func drawItemMarker(item: [AuctionItem]) {
    guard let kakaoMap else { return }
    let manager = kakaoMap.getLabelManager()
    let layer = manager.getLabelLayer(layerID: "PoiLayer")
    let poiOption = PoiOptions(styleID: "PerLevelStyle")
    poiOption.rank = 1
    
    // FIXME: Poi는 기술 및 기획검토 필요
    let iconStyle1 = PoiIconStyle(
      symbol: UIImage(systemName: "paperplane.fill"),
      anchorPoint: CGPoint(x: 0.5, y: 0.5),
      badges: []
    )
    let poiStyle = PoiStyle(styleID: "PerLevelStyle", styles: [
      PerLevelPoiStyle(iconStyle: iconStyle1, level: 999),
    ])
    manager.addPoiStyle(poiStyle)
    
    let poi1 = layer?.addPoi(option:poiOption, at: MapPoint(longitude: 37.3583237, latitude: 126.932912))
    poi1?.show()
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
