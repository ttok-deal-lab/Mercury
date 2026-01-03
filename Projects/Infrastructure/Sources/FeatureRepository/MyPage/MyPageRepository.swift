//
//  UserProfileRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/30/25.
//

import Foundation

import AppFoundation
import Networking
import Domain

enum UserProfileError: Error {
  case missingUserId
}

public final class MyPageRepository: MyPageRepositoriable {
  @LazyInject private var userProfileManager: UserProfileManagable
  private var signininformationManager = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  private var accessToken: UserAccessToken?
  
  public init() { }
  
  public func fetchUserProfile() async throws -> UserProfileInfo {
    guard let userID = signininformationManager.userInfo?.id else {
      throw UserProfileError.missingUserId
    }
    let userProfileInfoDTO = try await UserProfileAPI.userProfile(userID: userID)
      .request(UserProfileInfoDTO.self)
    let userProfile = userProfileInfoDTO.toUserProfileInfo()
    return userProfile
    
    
  }
  
  public func userProfile(userId: Int) async throws {
    let userProfileInfoDTO = try await UserProfileAPI.userProfile(
      userID: userId
    ).request(UserProfileInfoDTO.self)
    self.userProfileManager.setUserProfile(userProfileInfoDTO.toUserProfileInfo())
  }
  
}
