//
//  UserLocationUsecaseDependency.swift
//  Map
//
//  Created by 송하민 on 8/10/24.
//

import AppFoundation
import Dependencies
import Foundation
import CoreLocation
import ComposableArchitecture

public struct UserLocationClient {
  public var userAuthorization: () -> CLAuthorizationStatus
  public var userCurrentLocation: () -> CLLocation?
  public var requestUserAuthorization: () -> AsyncStream<CLAuthorizationStatus>
  
  public init(
    userAuthorization: @escaping () -> CLAuthorizationStatus,
    userCurrentLocation: @escaping () -> CLLocation?,
    requestUserAuthorization: @escaping () -> AsyncStream<CLAuthorizationStatus>
  ) {
    self.userAuthorization = userAuthorization
    self.userCurrentLocation = userCurrentLocation
    self.requestUserAuthorization = requestUserAuthorization
  }
}

extension UserLocationClient: TestDependencyKey {}

extension UserLocationClient: DependencyKey {
  
  public static let liveValue: Self = {
    
    let manager = CLLocationManager()
    let delegate = LocationManagerDelegate()
    manager.delegate = delegate
    manager.desiredAccuracy = kCLLocationAccuracyBest
    
    return Self(
      userAuthorization: {
        manager.authorizationStatus
      },
      userCurrentLocation: {
        manager.location
      },
      requestUserAuthorization: {
        AsyncStream { continuation in
          Task {
            let status = await delegate.requestAuthorization(manager: manager)
            continuation.yield(status)
            continuation.finish()
          }
        }
      }
    )
  }()
}

private final class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
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


extension DependencyValues {
  public var userLocationClient: UserLocationClient {
    get { self[UserLocationClient.self] }
    set { self[UserLocationClient.self] = newValue }
  }
}
