//
//  CrewLeaderUsecasable.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

public protocol CrewLeaderUsecasable {
  /// 내 크루장 정보. 신청 이력이 없으면 nil.
  func fetchMyCrewLeaderInfo() async throws -> CrewLeaderInfo?
}
