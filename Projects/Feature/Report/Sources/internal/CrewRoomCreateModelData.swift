//
//  CrewRoomCreateModelData.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import Foundation

import AppFoundation

@Observable
final class CrewRoomCreateModelData {
  // MARK: - internal property
  var title: String = ""
  var introduction: String = ""
  /// 지역/장소 선택 UI 가 아직 없어 선택 결과 문자열만 보관한다.
  var region: String?
  var place: String?
  var address: String = ""
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
    visitDate.map { Self.dateFormatter.string(from: $0) }
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
      && region != nil
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
  
  private static let feeFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
  
  // MARK: - life cycle
  init() { }
  
  // MARK: - internal method
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
