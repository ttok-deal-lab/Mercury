//
//  UserProfileUsecasable.swift
//  Domain
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation

public protocol MyPageUsecasable {
  func fetchUserProfile() async throws -> UserProfileInfo
  func openMail(recipent: String, title: String, body: String) async throws 
}
