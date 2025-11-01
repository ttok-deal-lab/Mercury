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

public final class UserProfileRepository: UserProfileRepositoriable {
  @LazyInject private var userProfileManager: UserProfileManagable
  private var signininformationManager = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  private let localStorageUsecase: LocalStorageUsecase
  private var accessToken: UserAccessToken?
  
  public init(localStorageUsecase: LocalStorageUsecase = LocalStorageUsecase(
    repository: UserDefaultsStoreRepository())
  ) {
    self.localStorageUsecase = localStorageUsecase 
  }
  
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
    guard let accessToken =  await self.localStorageUsecase.getModel(
      forKey: .signInTokenInfo,
      as: UserAccessToken.self)
    else {
      return
    }
    
    let userProfileInfoDTO = try await UserProfileAPI.userProfile(
      userID: userId
    ).request(UserProfileInfoDTO.self)
    self.userProfileManager.setUserProfile(userProfileInfoDTO.toUserProfileInfo())
  }

}
