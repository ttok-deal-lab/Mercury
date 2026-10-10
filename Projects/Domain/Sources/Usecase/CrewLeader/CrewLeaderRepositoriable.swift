//
//  CrewLeaderRepositoriable.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

public protocol CrewLeaderRepositoriable {
  /// 내 크루장 정보. 아직 신청하지 않아 서버에 정보가 없으면(404) nil.
  func fetchMyCrewLeaderInfo() async throws -> CrewLeaderInfo?
}
