//
//  UserLocationUsecaseDependency.swift
//  Map
//
//  Created by 송하민 on 8/10/24.
//

import Foundation
import ComposableArchitecture
import DomainInterface
import Domain

private enum UserLocationUsecaseKey: @preconcurrency DependencyKey {
  @MainActor static let liveValue: UserLocationUsecase = UserLocationUsecaseImplement()
}

extension DependencyValues {
  var userLocationUsecase: UserLocationUsecase {
    get { self[UserLocationUsecaseKey.self] }
    set { self[UserLocationUsecaseKey.self] = newValue }
  }
}

