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

public final class UserLocationUsecaseImplement: NSObject, UserLocationUsecase {
  
  // MARK: - private property

  private var authStatusContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
  private var updatedLocationContinuation: CheckedContinuation<CLLocation, Error>?
  
  
  // MARK: - public property
  
  @MainActor
  public lazy var locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    return manager
  }()
  
  
  // MARK: - life cycle
  
  public override init() {
    super.init()
  }
   
  deinit {
    print("\(self) is deinited.")
  }
  
  // MARK: - public method

  public func userAuthorization() async -> CLAuthorizationStatus {
    return await self.locationManager.authorizationStatus
  }

  public func userCurrentLocation() async -> CLLocation? {
    return await self.locationManager.location
  }
  
  public func requestUserAuthorization() async -> CLAuthorizationStatus {
    let currentStatus = await locationManager.authorizationStatus
    if currentStatus != .notDetermined {
      return currentStatus
    }
    return await withCheckedContinuation { continuation in
      self.authStatusContinuation = continuation
      DispatchQueue.main.async {
        self.locationManager.requestWhenInUseAuthorization()
      }
    }
  }
}

@MainActor
extension UserLocationUsecaseImplement: @preconcurrency CLLocationManagerDelegate {
  
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    if let continuation = self.authStatusContinuation {
      continuation.resume(returning: status)
      self.authStatusContinuation = nil
    }
  }
  
}
