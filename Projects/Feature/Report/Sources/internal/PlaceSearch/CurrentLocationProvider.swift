//
//  CurrentLocationProvider.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation
import CoreLocation

/// 지도 "내 위치" 버튼용 1회성 위치 조회. 권한이 없으면 요청하고, 거부되면 nil.
final class CurrentLocationProvider: NSObject, CLLocationManagerDelegate {
  private let manager = CLLocationManager()
  private var continuation: CheckedContinuation<CLLocationCoordinate2D?, Never>?
  
  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
  }
  
  @MainActor
  func requestCurrentLocation() async -> CLLocationCoordinate2D? {
    guard continuation == nil else { return nil }
    switch manager.authorizationStatus {
    case .denied, .restricted:
      return nil
    default:
      break
    }
    return await withCheckedContinuation { continuation in
      self.continuation = continuation
      if manager.authorizationStatus == .notDetermined {
        manager.requestWhenInUseAuthorization()
      } else {
        manager.requestLocation()
      }
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    guard continuation != nil else { return }
    switch manager.authorizationStatus {
    case .authorizedWhenInUse, .authorizedAlways:
      manager.requestLocation()
    case .denied, .restricted:
      finish(nil)
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    finish(locations.last?.coordinate)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    finish(nil)
  }
  
  private func finish(_ coordinate: CLLocationCoordinate2D?) {
    continuation?.resume(returning: coordinate)
    continuation = nil
  }
}
