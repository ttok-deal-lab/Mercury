//
//  UserProfileUsecase.swift
//  Domain
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation

public class MyPageUsecase: MyPageUsecasable {

  private let fetcher: UerProfileFetcher
  private let mailManager: MailManagerable
  
  public init(
    repository: MyPageRepositoriable,
    mailManager: MailManagerable
  ) {
    self.fetcher = UerProfileFetcher(repository: repository)
    self.mailManager = mailManager
  }
  
  public func fetchUserProfile() async throws -> UserProfileInfo {
    return try await self.fetcher.fetchProfile()
  }
  
  public func openMail(recipent: String, title: String, body: String) async throws {
    self.mailManager.openMail(
      recipient: recipent,
      title: title,
      body: body
    )
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
