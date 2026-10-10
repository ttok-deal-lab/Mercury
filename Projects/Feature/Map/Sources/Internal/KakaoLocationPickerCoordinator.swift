//
//  KakaoLocationPickerCoordinator.swift
//  Map
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation
import CoreLocation
import KakaoMapsSDK

final class KakaoLocationPickerCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate {
  
  var parent: KakaoLocationPickerMapView
  var controller: KMController?
  var lastMoveRequestID: UUID?
  
  private var kakaoMap: KakaoMap?
  private var pendingCoordinate: CLLocationCoordinate2D?
  
  init(parent: KakaoLocationPickerMapView) {
    self.parent = parent
    super.init()
  }
  
  func createController(_ view: KMViewContainer) {
    controller = KMController(viewContainer: view)
    controller?.delegate = self
    controller?.prepareEngine()
    controller?.activateEngine()
  }
  
  // MARK: - MapControllerDelegate
  
  func addViews() {
    let position = MapPoint(longitude: parent.initialCoordinate.longitude, latitude: parent.initialCoordinate.latitude)
    let info = MapviewInfo(viewName: "pickerMap", viewInfoName: "map", defaultPosition: position, defaultLevel: 16)
    controller?.addView(info)
  }
  
  func addViewSucceeded(_ viewName: String, viewInfoName: String) {
    kakaoMap = controller?.getView(viewName) as? KakaoMap
    kakaoMap?.eventDelegate = self
    if let pendingCoordinate {
      self.pendingCoordinate = nil
      moveCamera(to: pendingCoordinate)
    } else {
      // 첫 진입 좌표의 주소도 바로 보여주기 위해 한 번 알린다.
      parent.onCenterChanged(parent.initialCoordinate)
    }
  }
  
  func containerDidResized(_ size: CGSize) {
    kakaoMap?.viewRect = CGRect(origin: .zero, size: size)
  }
  
  // MARK: - KakaoMapEventDelegate
  
  func cameraWillMove(kakaoMap: KakaoMap, by: MoveBy) {
    parent.onMoveStarted()
  }
  
  func cameraDidStopped(kakaoMap: KakaoMap, by: MoveBy) {
    let rect = kakaoMap.viewRect
    let center = kakaoMap.getPosition(CGPoint(x: rect.width / 2, y: rect.height / 2))
    parent.onCenterChanged(
      CLLocationCoordinate2D(latitude: center.wgsCoord.latitude, longitude: center.wgsCoord.longitude)
    )
  }
  
  // MARK: - internal method
  
  func moveCamera(to coordinate: CLLocationCoordinate2D) {
    guard let kakaoMap else {
      pendingCoordinate = coordinate
      return
    }
    let target = MapPoint(longitude: coordinate.longitude, latitude: coordinate.latitude)
    kakaoMap.animateCamera(
      cameraUpdate: CameraUpdate.make(target: target, mapView: kakaoMap),
      options: CameraAnimationOptions(autoElevation: false, consecutive: false, durationInMillis: 300)
    )
  }
}
