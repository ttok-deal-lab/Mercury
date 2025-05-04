//
//  UserLocationClientLive.swift
//  Map
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import CoreLocation
import Combine

public final class LocationUsecase: LocationUsecasable {

  private var delegate = LocationDelegate()
  private let manager = CLLocationManager()
  
  public init() {
    manager.delegate = self.delegate
    manager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  public func userAuthorization() -> CLAuthorizationStatus? {
    manager.authorizationStatus
  }
  
  public func userCurrentLocation() -> CLLocationCoordinate2D? {
    manager.location?.coordinate
  }
  
  public func requestUserAuthorization() async -> CLAuthorizationStatus? {
    await delegate.requestAuthorization(manager: manager)
  }
}

final class LocationDelegate: NSObject, CLLocationManagerDelegate {
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
