//
//  MyPageModelData.swift
//  Profile
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import Combine

import AppFoundation
import Router
import Domain

@Observable
public final class MyPageModelData {
  
  // MARK: - internal property
  
  var userProfile: UserProfileInfo = .init(
    id: 0,
    oauthId: "",
    provider: .kakao,
    email: "",
    name: "Unknown",
    status: .inactive
  )
  
  // MARK: - private property
  private var userProfileUsecasable: UserProfileUsecasable
  
  // MARK: - life cycle
  
  init(userProfileUsecasable: UserProfileUsecasable) {
    self.userProfileUsecasable = userProfileUsecasable
  }
  
  func fetchProfile() async throws {
    do {
      let userProfile = try await userProfileUsecasable.fetchUserProfile()
      self.userProfile = userProfile
    } catch {
      throw error
    }
  }
}

