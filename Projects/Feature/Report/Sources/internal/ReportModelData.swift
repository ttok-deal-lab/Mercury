//
//  ReportModelData.swift
//  Report
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import AppFoundation
import Domain

@Observable
final class ReportModelData {
  // MARK: - internal property
  var crewList: [ReportCrewItem] = []
  var selectedFilter: ReportCrewFilterType = .all
  var isLoading: Bool = false
  var error: Error?
  
  var filteredCrewList: [ReportCrewItem] {
    switch selectedFilter {
    case .all: return crewList
    case .mine: return crewList.filter(\.isJoined)
    }
  }
  
  // MARK: - life cycle
  init() { }
  
  // MARK: - internal method
  func onAppear() async {
    isLoading = true
    defer { isLoading = false }
    // 크루 API 가 아직 없어 초기 화면 확인용 목 데이터를 노출한다.
    crewList = Self.mockCrewList
  }
  
  func applyCrewLeader() {
    // 크루장 신청 플로우(라우트/API) 가 확정되면 연결한다.
  }
  
  // MARK: - private property
  private static let mockCrewList: [ReportCrewItem] = [
    ReportCrewItem(
      id: 1,
      name: "관악구 봉천동 일대",
      status: .recruiting,
      remainingDays: 7,
      currentCount: 5,
      capacity: 10,
      isJoined: true
    ),
    ReportCrewItem(
      id: 2,
      name: "관악구 봉천동 일대",
      status: .recruiting,
      remainingDays: 3,
      currentCount: 5,
      capacity: 10,
      isJoined: false
    )
  ]
}
