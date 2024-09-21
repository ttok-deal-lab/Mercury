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

@DependencyClient
public struct UserLocationClient {
  public var userAuthorization: @Sendable () -> CLAuthorizationStatus?
  public var userCurrentLocation: @Sendable () -> CLLocation?
  public var requestUserAuthorization: @Sendable () async -> CLAuthorizationStatus?
}

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
        await delegate.requestAuthorization(manager: manager)
      }
    )
  }()
}

extension UserLocationClient: TestDependencyKey {}

extension DependencyValues {
  public var userLocationClient: UserLocationClient {
    get { self[UserLocationClient.self] }
    set { self[UserLocationClient.self] = newValue }
  }
}

