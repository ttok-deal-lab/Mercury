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
  /// 서버 크루장 상태. 신청 이력이 없으면 nil.
  var crewLeaderStatus: CrewLeaderStatusType?
  var isLoading: Bool = false
  var error: Error?
  
  /// 크루장 승인(ACTIVE) 여부. 상단 배너가 신청 안내 ↔ 크루 만들기 로 바뀐다.
  var isCrewLeader: Bool {
    crewLeaderStatus == .active
  }
  
  var filteredCrewList: [ReportCrewItem] {
    switch selectedFilter {
    case .all: return crewList
    case .mine: return crewList.filter(\.isJoined)
    }
  }
  
  // MARK: - private property
  private let crewLeaderUsecase: CrewLeaderUsecasable
  
  // MARK: - life cycle
  init(crewLeaderUsecase: CrewLeaderUsecasable) {
    self.crewLeaderUsecase = crewLeaderUsecase
  }
  
  // MARK: - internal method
  func onAppear() async {
    isLoading = true
    defer { isLoading = false }
    // 크루 API 가 아직 없어 초기 화면 확인용 목 데이터를 노출한다.
    crewList = Self.mockCrewList
    await loadCrewLeaderStatus()
  }
  
  // MARK: - private method
  
  /// 배너 분기용 조회. 실패해도 탭 진입마다 alert 를 띄우지 않도록 비크루장으로 두고 로그만 남긴다.
  private func loadCrewLeaderStatus() async {
    do {
      let info = try await crewLeaderUsecase.fetchMyCrewLeaderInfo()
      crewLeaderStatus = info?.status
    } catch {
      crewLeaderStatus = nil
      Log.debug("크루장 정보 조회 실패: \(error)")
    }
  }
  
  // MARK: - mock
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
