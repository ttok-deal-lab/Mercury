//
//  MapUsecase.swift
//  DomainInterface
//
//  Created by 송하민 on 8/10/24.
//


import CoreLocation
import AppFoundation

public protocol UserLocationUsecase {
  
  var locationManager: CLLocationManager { get }
  
  func userAuthorization() async -> CLAuthorizationStatus
  func requestUserAuthorization() async -> CLAuthorizationStatus
  func userCurrentLocation() async -> CLLocation?
  
}