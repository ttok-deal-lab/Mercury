//
//  UserLocationClient.swift
//  Map
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import CoreLocation

protocol UserLocationClient {
  func userAuthorization() -> CLAuthorizationStatus?
  func userCurrentLocation() -> CLLocationCoordinate2D?
  func requestUserAuthorization() async -> CLAuthorizationStatus?
}
