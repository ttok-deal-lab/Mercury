//
//  VisitDateModelData.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

@Observable
final class VisitDateModelData {
  // MARK: - internal property
  /// 달력에 보이는 달의 1일
  var displayedMonth: Date
  var selectedDay: Date?
  var hour: Int?
  var minute: Int?
  
  let calendar: Calendar
  let hours: [Int] = Array(0...23)
  let minutes: [Int] = stride(from: 0, to: 60, by: 10).map { $0 }
  
  var isSelectable: Bool {
    selectedDay != nil && hour != nil && minute != nil
  }
  
  /// 날짜 + 시간을 합친 결과
  var selectedDate: Date? {
    guard let selectedDay, let hour, let minute else { return nil }
    return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: selectedDay)
  }
  
  /// 하단 요약. 예) 23.10.21(월)
  var selectedDayText: String? {
    selectedDay.map { Self.summaryFormatter.string(from: $0) }
  }
  
  /// 하단 요약 시간. 예) 14:30
  var selectedTimeText: String? {
    guard let hour, let minute else { return nil }
    return String(format: "%02d:%02d", hour, minute)
  }
  
  var monthTitle: String {
    Self.monthFormatter.string(from: displayedMonth)
  }
  
  /// 달력 칸: 첫 주 앞쪽 빈칸은 nil
  var dayCells: [Date?] {
    guard let range = calendar.range(of: .day, in: .month, for: displayedMonth) else { return [] }
    let firstWeekday = calendar.component(.weekday, from: displayedMonth)
    let leading = (firstWeekday - calendar.firstWeekday + 7) % 7
    let days: [Date?] = range.compactMap { day in
      calendar.date(byAdding: .day, value: day - 1, to: displayedMonth)
    }
    return Array(repeating: nil, count: leading) + days
  }
  
  /// 요일 헤더 (일 월 화 …)
  var weekdaySymbols: [String] {
    let symbols = Self.monthFormatter.veryShortWeekdaySymbols ?? []
    let start = calendar.firstWeekday - 1
    return Array(symbols[start...] + symbols[..<start])
  }
  
  // MARK: - private property
  private static let summaryFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy.MM.dd(E)"
    return formatter
  }()
  
  private static let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM"
    return formatter
  }()
  
  // MARK: - life cycle
  init(initialDate: Date?, calendar: Calendar = .current) {
    self.calendar = calendar
    let base = initialDate ?? Date()
    self.displayedMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: base)) ?? base
    if let initialDate {
      self.selectedDay = calendar.startOfDay(for: initialDate)
      self.hour = calendar.component(.hour, from: initialDate)
      self.minute = calendar.component(.minute, from: initialDate) / 10 * 10
    }
  }
  
  // MARK: - internal method
  func moveMonth(by value: Int) {
    guard let moved = calendar.date(byAdding: .month, value: value, to: displayedMonth) else { return }
    displayedMonth = moved
  }
  
  /// 이번 달보다 앞으로는 못 간다 (지난 날짜는 고를 수 없음)
  var canMoveToPreviousMonth: Bool {
    let thisMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())) ?? Date()
    return displayedMonth > thisMonth
  }
  
  func isPast(_ day: Date) -> Bool {
    day < calendar.startOfDay(for: Date())
  }
  
  func isToday(_ day: Date) -> Bool {
    calendar.isDateInToday(day)
  }
  
  func isSelected(_ day: Date) -> Bool {
    guard let selectedDay else { return false }
    return calendar.isDate(day, inSameDayAs: selectedDay)
  }
  
  /// 1 = 일요일, 7 = 토요일
  func weekday(of day: Date) -> Int {
    calendar.component(.weekday, from: day)
  }
  
  func select(_ day: Date) {
    guard !isPast(day) else { return }
    selectedDay = day
  }
}
