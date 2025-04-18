//
//  LocationManagerDelegate.swift
//  Data
//
//  Created by 송하민 on 9/21/24.
//

import Foundation
import CoreLocation

final class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
  var authStatusContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    if let continuation = self.authStatusContinuation {
      continuation.resume(returning: status)
      self.authStatusContinuation = nil
    }
  }
  
  func requestAuthorization(manager: CLLocationManager) async -> CLAuthorizationStatus {
    let currentStatus = manager.authorizationStatus
    if currentStatus != .notDetermined {
      return currentStatus
    }
    return await withCheckedContinuation { continuation in
      self.authStatusContinuation = continuation
      manager.requestWhenInUseAuthorization()
    }
  }
}
