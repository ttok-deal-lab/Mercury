//
//  SettingUsecase.swift
//  Domain
//
//  Created by 최수훈 on 1/2/26.
//
import Foundation

public class SettingUsecase: SettingUsecasable {
  private var fetcher: SettingFetcher
  
  public init(repository: SettingRepositoriable) {
    self.fetcher = SettingFetcher(repository: repository)
  }
  public func signOut() async throws {
    try await fetcher.signOut()
  }

  public func logout() async throws {
    try await fetcher.logout()
  }
}

actor SettingFetcher {
  let repository: SettingRepositoriable
  
  init(repository: SettingRepositoriable) {
    self.repository = repository
  }
  
  func signOut() async throws {
    try await repository.signOut()
  }

  func logout() async throws {
    try await repository.logout()
  }
}
