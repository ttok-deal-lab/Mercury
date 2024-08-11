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

public final class UserLocationUsecaseImplement: NSObject, UserLocationUsecase, @preconcurrency CLLocationManagerDelegate {

  
  // MARK: - private property

  private var authStatusContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
  private var updatedLocationContinuation: CheckedContinuation<CLLocation, Error>?
  
  
  // MARK: - public property
  
  public var locationManager: CLLocationManager = CLLocationManager()
  
  
  // MARK: - life cycle
  
  public override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.distanceFilter = 50
    self.locationManager.startUpdatingLocation()
  }
   
  deinit {
    print("\(self) is deinited.")
  }
  
  // MARK: - public method
  
  public func userAuthorization() async -> CLAuthorizationStatus {
    return self.locationManager.authorizationStatus
  }
  
  public func userCurrentLocation() -> CLLocation? {
    return self.locationManager.location
  }
  
  @MainActor public func requestUserAuthorization() async -> CLAuthorizationStatus {
    let currentStatus = locationManager.authorizationStatus
    if currentStatus != .notDetermined {
      return currentStatus
    }
    return await withCheckedContinuation { @MainActor continuation in
      self.authStatusContinuation = continuation
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  public func startUpdatingLocation() async throws -> CLLocation {
    self.locationManager.startUpdatingLocation()
    let location = try await withCheckedThrowingContinuation({ continuation in
      updatedLocationContinuation = continuation
    })
    return location
  }
  
  @MainActor public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    print("Authorization status changed to: \(status)")
    
    if let continuation = self.authStatusContinuation {
      continuation.resume(returning: status)
      self.authStatusContinuation = nil
    }
  }
  
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      updatedLocationContinuation?.resume(returning: location)
      updatedLocationContinuation = nil
    }
  }
  
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    updatedLocationContinuation?.resume(throwing: MercuryError(from: .ownModule(.map), .unknown))
    updatedLocationContinuation = nil
  }
  
}
