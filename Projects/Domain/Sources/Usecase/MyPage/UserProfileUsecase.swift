//
//  UserProfileUsecase.swift
//  Domain
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation


public class UserProfileUsecase: UserProfileUsecasable {
  private let fetcher: UerProfileFetcher
  
  public init(repository: UserProfileRepositoriable) {
    self.fetcher = UerProfileFetcher(repository: repository)
  }
  
  public func fetchUserProfile() async throws -> UserProfileInfo {
    return try await self.fetcher.fetchProfile()
  }
}

actor UerProfileFetcher {
  let repository: UserProfileRepositoriable
  
  init(repository: UserProfileRepositoriable) {
    self.repository = repository
  }
  
  func fetchProfile() async throws  -> UserProfileInfo {
    let fetchUserProfile = try await repository.fetchUserProfile()
    return fetchUserProfile
  }
}
