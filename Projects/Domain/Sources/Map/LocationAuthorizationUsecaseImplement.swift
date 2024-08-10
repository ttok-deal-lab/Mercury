//
//  MapUsecaseImplement.swift
//  Domain
//
//  Created by 송하민 on 8/10/24.
//

import AppFoundation
import Foundation
import CoreLocation
import DomainInterface

public final class LocationAuthorizationUsecaseImplement: LocationAuthorizationUsecase {

  // MARK: - public property
  
  public var locationManager: CLLocationManager = CLLocationManager()
  
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  
  // MARK: - public method
  
  public func userAuthorization() async -> Result<CLAuthorizationStatus, MercuryError> {
    let status = self.locationManager.authorizationStatus
    return .success(status)
  }
  
  public func requestUserAuthorization() {
    self.locationManager.requestWhenInUseAuthorization()
  }
  
  public func userCurrentLocation() -> CLLocation? {
    return self.locationManager.location
  }
  
  
  
}
