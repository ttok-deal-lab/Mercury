//
//  CrewRoomCreateModelData.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import Foundation

import AppFoundation
import Domain

@Observable
final class CrewRoomCreateModelData {
  // MARK: - internal property
  var title: String = ""
  var introduction: String = ""
  /// 지역 선택 시트에 쓰는 시/도·구/군 목록 (홈 지역 필터와 같은 서버 데이터)
  var regions: [Region] = []
  var selectedRegion: Region?
  var selectedDistrict: District?
  /// 모임장소 (주소 검색/지도에서 고른 주소)
  var place: AddressInfo?
  /// 세부 주소 (동·호수 등 직접 입력)
  var address: String = ""
  /// 임장 날짜 + 시작 시간
  var visitDate: Date?
  var recruitStartDate: Date?
  var recruitEndDate: Date?
  /// 숫자만 보관한다.
  var maxMembers: String = ""
  var fee: String = ""
  var selectedAnalysisTypes: [CrewAnalysisType] = []
  /// 선택한 분석 항목 전체에 대한 내용 (항목별이 아니라 하나의 에디터)
  var analysisContent: String = ""
  var isLoading: Bool = false
  var error: Error?
  
  var visitDateText: String? {
    visitDate.map { Self.dateTimeFormatter.string(from: $0) }
  }
  
  /// 지역 칩 표시. 예) 서울특별시 종로구
  var regionText: String? {
    guard let selectedRegion else { return nil }
    return [selectedRegion.displayName, selectedDistrict?.displayName].compactMap { $0 }.joined(separator: " ")
  }
  
  /// 주소 검색 결과의 "서비스 가능 지역" 판정 기준. 서버 기준이 없어 고른 지역(시/도) 과 같은 시/도면 가능으로 본다.
  var serviceRegionName: String? {
    selectedRegion?.displayName
  }
  
  var recruitPeriodText: String? {
    guard let start = recruitStartDate, let end = recruitEndDate else { return nil }
    return "\(Self.dateFormatter.string(from: start))-\(Self.dateFormatter.string(from: end))"
  }
  
  /// 분석 섹션 제목: 선택한 항목을 칩 순서대로 " / " 로 이어 붙인다. 예) 상권분석 / 주변인프라 / 시세
  var analysisSectionTitle: String {
    CrewAnalysisType.allCases
      .filter { selectedAnalysisTypes.contains($0) }
      .map(\.title)
      .joined(separator: " / ")
  }
  
  /// 참가비 표시용 (천 단위 구분)
  var feeText: String {
    guard let value = Int(fee) else { return "" }
    return Self.feeFormatter.string(from: NSNumber(value: value)) ?? fee
  }
  
  /// 디자인상 필수(*) 항목이 모두 채워졌는지
  var isSubmittable: Bool {
    !title.trimmingCharacters(in: .whitespaces).isEmpty
      && selectedRegion != nil
      && place != nil
      && visitDate != nil
      && recruitStartDate != nil
      && recruitEndDate != nil
      && !maxMembers.isEmpty
      && !fee.isEmpty
  }
  
  // MARK: - private property
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter
  }()
  
  private static let dateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd HH:mm"
    return formatter
  }()
  
  private static let feeFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
  
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  
  // MARK: - life cycle
  init(auctionSearchFilterUsecase: AuctionSearchFilterUsecasable) {
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
  }
  
  // MARK: - internal method
  func loadRegions() async {
    guard regions.isEmpty else { return }
    do {
      regions = try await auctionSearchFilterUsecase.fetchAuctionSearchFilters().regions
    } catch {
      self.error = error.toMercuryError() ?? MercuryError(.unknown)
    }
  }
  
  func selectRegion(id: String) {
    guard selectedRegion?.id != id else { return }
    selectedRegion = regions.first { $0.id == id }
    selectedDistrict = nil
  }
  
  func selectDistrict(id: String) {
    selectedDistrict = selectedRegion?.districts.first { $0.id == id }
  }
  
  func updateMaxMembers(_ raw: String) {
    maxMembers = raw.filter(\.isNumber)
  }
  
  func updateFee(_ raw: String) {
    fee = raw.filter(\.isNumber)
  }
  
  func toggleAnalysisType(_ type: CrewAnalysisType) {
    if let index = selectedAnalysisTypes.firstIndex(of: type) {
      selectedAnalysisTypes.remove(at: index)
    } else {
      selectedAnalysisTypes.append(type)
    }
  }
  
  func updateRecruitPeriod(start: Date, end: Date) {
    recruitStartDate = start
    recruitEndDate = max(start, end)
  }
  
  /// 방 생성 성공 여부. API 가 확정되면 UseCase 호출 결과로 교체한다. 지금은 화면 흐름 확인을 위해 항상 성공.
  func submit() async -> Bool {
    isLoading = true
    defer { isLoading = false }
    return true
  }
}
