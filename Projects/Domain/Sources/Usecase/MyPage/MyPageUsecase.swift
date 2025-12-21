//
//  UserProfileUsecase.swift
//  Domain
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation


public class MyPageUsecase: MyPageUsecasable {
  private let fetcher: UerProfileFetcher
  
  public init(repository: MyPageRepositoriable) {
    self.fetcher = UerProfileFetcher(repository: repository)
  }
  
  public func fetchUserProfile() async throws -> UserProfileInfo {
    return try await self.fetcher.fetchProfile()
  }
}

actor UerProfileFetcher {
  let repository: MyPageRepositoriable
  
  init(repository: MyPageRepositoriable) {
    self.repository = repository
  }
  
  func fetchProfile() async throws  -> UserProfileInfo {
    let fetchUserProfile = try await repository.fetchUserProfile()
    return fetchUserProfile
  }
}
