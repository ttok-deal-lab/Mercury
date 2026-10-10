//
//  CrewLeaderUsecase.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

public final class CrewLeaderUsecase: CrewLeaderUsecasable {
  
  private let repository: CrewLeaderRepositoriable
  
  public init(repository: CrewLeaderRepositoriable) {
    self.repository = repository
  }
  
  public func fetchMyCrewLeaderInfo() async throws -> CrewLeaderInfo? {
    try await repository.fetchMyCrewLeaderInfo()
  }
}
