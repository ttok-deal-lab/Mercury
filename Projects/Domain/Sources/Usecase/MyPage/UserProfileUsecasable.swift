//
//  UserProfileUsecasable.swift
//  Domain
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation

public protocol UserProfileUsecasable {
  func fetchUserProfile() async throws -> UserProfileInfo
}
