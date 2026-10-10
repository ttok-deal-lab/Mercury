//
//  CrewLeaderStatusType.swift
//  Domain
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

/// 서버 `CrewLeader.status` 값. 승인(ACTIVE) 상태만 크루장으로 취급한다.
public enum CrewLeaderStatusType: String, Sendable, CaseIterable {
  case active = "ACTIVE"
  case inactive = "INACTIVE"
  case pending = "PENDING"
  case rejected = "REJECTED"
  case suspended = "SUSPENDED"
  case deleted = "DELETED"
}
