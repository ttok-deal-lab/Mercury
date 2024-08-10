//
//  MapUsecase.swift
//  DomainInterface
//
//  Created by 송하민 on 8/10/24.
//

import CoreLocation
import Foundation
import AppFoundation
import ComposableArchitecture

public protocol LocationAuthorizationUsecase {
  
  var locationManager: CLLocationManager { get }
  func userAuthorization() async -> Result<CLAuthorizationStatus, MercuryError>
  func requestUserAuthorization()
  func userCurrentLocation() -> CLLocation?
  
}

//private enum LocationAuthorizationUsecaseKey: DependencyKey {
//  static let liveValue: LocationAuthorizationUsecase = LocationAuthorizationUsecaseImplement()
////  static var testValue: LocationAuthorizationUsecase = UnimplementedLocationAuthorizationUsecase()
//}
//
//extension DependencyValues {
//  var locationAuthorizationUsecase: LocationAuthorizationUsecase {
//    get { self[LocationAuthorizationUsecaseKey.self] }
//    set { self[LocationAuthorizationUsecaseKey.self] = newValue }
//  }
//}
