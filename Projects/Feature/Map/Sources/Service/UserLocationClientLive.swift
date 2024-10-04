//
//  UserLocationClientLive.swift
//  Map
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import CoreLocation
import Combine

class UserLocationClientLive: UserLocationClient {

  private var delegate = LocationManagerDelegate()
  private let manager = CLLocationManager()
  
  init() {
    manager.delegate = self.delegate
    manager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func userAuthorization() -> CLAuthorizationStatus? {
    manager.authorizationStatus
  }
  
  func userCurrentLocation() -> CLLocationCoordinate2D? {
    manager.location?.coordinate
  }
  
  func requestUserAuthorization() async -> CLAuthorizationStatus? {
    await delegate.requestAuthorization(manager: manager)
  }
  
  
  
}

