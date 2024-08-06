//
//  KakaoMapView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/6/24.
//

import SwiftUI
import KakaoMapsSDK
import KakaoMapsSDK_SPM

struct KakaoMapView: UIViewRepresentable {
  @Binding var draw: Bool

  func makeUIView(context: Self.Context) -> KMViewContainer {
    let view: KMViewContainer = KMViewContainer()
    view.sizeToFit()
    context.coordinator.createController(view)
    context.coordinator.controller?.prepareEngine()
    
    return view
  }
  
  func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
    if draw {
      context.coordinator.controller?.activateEngine()
    } else {
      context.coordinator.controller?.resetEngine()
    }
  }
  
  func makeCoordinator() -> KakaoMapCoordinator {
    return KakaoMapCoordinator()
  }

  /// Coordinator 구현. KMControllerDelegate를 adopt한다.
  class KakaoMapCoordinator: NSObject, MapControllerDelegate {
    
    override init() {
      first = true
      super.init()
    }
    
    // KMController 객체 생성 및 event delegate 지정
    func createController(_ view: KMViewContainer) {
      controller = KMController(viewContainer: view)
      controller?.delegate = self
    }
    
    // KMControllerDelegate Protocol method구현
    
    /// 엔진 생성 및 초기화 이후, 렌더링 준비가 완료되면 아래 addViews를 호출한다.
    /// 원하는 뷰를 생성한다.
    @objc func addViews() {
      let defaultPosition: MapPoint = MapPoint(longitude: 14135167.020272, latitude: 4518393.389136)
      let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
      
      controller?.addView(mapviewInfo)
    }
    
    //addView 성공 이벤트 delegate. 추가적으로 수행할 작업을 진행한다.
    @objc func addViewSucceeded(_ viewName: String, viewInfoName: String) {
      print("OK") //추가 성공. 성공시 추가적으로 수행할 작업을 진행한다.
    }
    
    //addView 실패 이벤트 delegate. 실패에 대한 오류 처리를 진행한다.
    @objc func addViewFailed(_ viewName: String, viewInfoName: String) {
      print("Failed")
    }
    
    /// KMViewContainer 리사이징 될 때 호출.
    @objc func containerDidResized(_ size: CGSize) {
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
