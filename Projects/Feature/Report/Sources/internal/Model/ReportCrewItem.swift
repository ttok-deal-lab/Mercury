//
//  ReportCrewItem.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import Foundation

struct ReportCrewItem: Identifiable {
  let id: Int
  let name: String
  let status: ReportCrewStatusType
  let remainingDays: Int
  let currentCount: Int
  let capacity: Int
  let isJoined: Bool
  
  var successRate: Int {
    guard capacity > 0 else { return 0 }
    return currentCount * 100 / capacity
  }
}
