//
//  UserProfileRepositoriable.swift
//  Domain
//
//  Created by 최수훈 on 10/30/25.
//

import Foundation

import Combine

public protocol UserProfileRepositoriable {
  func fetchUserProfile() async throws -> UserProfileInfo
}
