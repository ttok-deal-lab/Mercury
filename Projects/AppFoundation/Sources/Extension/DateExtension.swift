//
//  DateExtension.swift
//  AppFoundation
//
//  Created by 최수훈 on 8/9/26.
//

import Foundation

public extension Date {
  /// 기준일 대비 이 날짜의 D-day 오프셋.
  ///
  /// 시각(hh:mm:ss)은 무시하고 캘린더상 날짜 차이만 계산한다.
  /// `timeIntervalSince`를 86400으로 나누는 방식은 나머지가 0 방향으로 절삭돼
  /// 매각 시각이 지난 시점부터 하루가 사라지므로 사용하지 않는다.
  ///
  /// - Parameters:
  ///   - reference: 비교 기준일. 기본값은 현재 시각.
  ///   - calendar: 날짜 경계를 판단할 캘린더. 기본값은 사용자 캘린더.
  /// - Returns: 미래면 음수(`D-n`), 당일이면 `0`, 과거면 양수(`D+n`)
  func dDayOffset(from reference: Date = Date(), calendar: Calendar = .current) -> Int {
    let referenceDay = calendar.startOfDay(for: reference)
    let targetDay = calendar.startOfDay(for: self)
    let dayDifference = calendar.dateComponents([.day], from: referenceDay, to: targetDay).day ?? 0
    return -dayDifference
  }
}
