//
//  StringExtension.swift
//  AppFoundation
//
//  Created by 송하민 on 11/2/25.
//

import Foundation

public extension String {
  func toKoreanDate() -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    return formatter.date(from: self) ?? Date()
  }
}
