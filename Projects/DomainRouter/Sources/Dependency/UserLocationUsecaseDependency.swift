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

public enum UserLocationUsecaseKey: DependencyKey {
  public static let liveValue: UserLocationUsecase = UserLocationUsecaseImplement()
}

extension DependencyValues {
  public var userLocationUsecase: UserLocationUsecase {
    get { self[UserLocationUsecaseKey.self] }
    set { self[UserLocationUsecaseKey.self] = newValue }
  }
}

