//
//  KakaoMapCoordinator.swift
//  Map
//
//  Created by 송하민 on 8/14/24.
//

import AppFoundation
import Foundation
import CoreLocation

import Domain
import UIComponent

import KakaoMapsSDK

public class KakaoMapCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate {
  
  // MARK: - private property
  
  private let parent: KakaoMapView
  private let firstMapCenterPoint: MapPoint
  
  private var isFirstEntry: Bool = true
  private var isMapReady: Bool = false
  private var pendingCameraUpdate: (() -> Void)?
  private var kakaoMap: KakaoMap?
  
  // MARK: - public property
  
  public var controller: KMController?
  
  
  // MARK: - life cycle
  
  public init(
    parent: KakaoMapView,
    longitude: Double,
    latitude: Double
  ) {
    self.parent = parent
    self.firstMapCenterPoint = MapPoint(longitude: longitude, latitude: latitude)
    
    super.init()
  }
  
  public func createController(_ view: KMViewContainer) {
    controller = KMController(viewContainer: view)
    controller?.delegate = self
    controller?.prepareEngine()
  }
  
  @objc public func addViews() {
    let defaultPosition: MapPoint = self.firstMapCenterPoint // 초기 좌표
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
    self.createCenterPoiStyle()
    self.addCenterPoi()
  }
  
  private func createLabelLayer() {
    guard let kakaoMap else { return }
    let manager = kakaoMap.getLabelManager()
    let layerOption = LabelLayerOptions(
      layerID: "PoiLayer",
      competitionType: .none,
      competitionUnit: .symbolFirst,
      orderType: .rank,
      zOrder: 10
    )
    let _ = manager.addLabelLayer(option: layerOption)
  }
  
  private func createCenterPoiStyle() {
    guard let kakaoMap else { return }
    let manager = kakaoMap.getLabelManager()
    
    let symbolImage = UIImage(named: "Place", in: Bundle.module, compatibleWith: nil)

    let icon = PoiIconStyle(
      symbol: symbolImage,
      anchorPoint: CGPoint(x: 0.5, y: 1.0),  // 핀 바닥이 좌표에 닿도록
      badges: []
    )


    let perLevel = PerLevelPoiStyle(iconStyle: icon, level: 0)

    let style = PoiStyle(
      styleID: "CenterPoiStyle",
      styles: [perLevel]
    )

    manager.addPoiStyle(style)
  }
  
  private func addCenterPoi() {
    guard let kakaoMap else { return }
    let manager = kakaoMap.getLabelManager()
    guard let layer = manager.getLabelLayer(layerID: "PoiLayer") else { return }

    let option = PoiOptions(styleID: "CenterPoiStyle")
    option.rank = 0

    let poi = layer.addPoi(option: option, at: self.firstMapCenterPoint)
    poi?.show() // 표출
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

