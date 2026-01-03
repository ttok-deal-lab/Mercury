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
final class MyPageModelData {
  
  // MARK: - internal property
  
  var userProfile: UserProfileInfo?
  
  // MARK: - private property
  private var userProfileUsecasable: MyPageUsecasable
  
  // MARK: - life cycle
  
  init(userProfileUsecasable: MyPageUsecasable) {
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

