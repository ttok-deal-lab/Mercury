//
//  LocationAuthorizationUsecaseDependency.swift
//  Map
//
//  Created by 송하민 on 8/10/24.
//

import Foundation
import ComposableArchitecture
import DomainInterface
import Domain

private enum LocationAuthorizationUsecaseKey: DependencyKey {
  static let liveValue: LocationAuthorizationUsecase = LocationAuthorizationUsecaseImplement()
//  static var testValue: LocationAuthorizationUsecase = UnimplementedLocationAuthorizationUsecase()
}

extension DependencyValues {
  var locationAuthorizationUsecase: LocationAuthorizationUsecase {
    get { self[LocationAuthorizationUsecaseKey.self] }
    set { self[LocationAuthorizationUsecaseKey.self] = newValue }
  }
}

