//
//  KoreanDateFormat.swift
//  AppFoundation
//
//  Created by 송하민 on 12/13/25.
//

import Foundation

extension Date {
  enum KoreanDateFormat {
    case full                   // "2024년 7월 23일 (화) 오전 9:00"
    case dateOnly               // "2024년 7월 23일"
    case dateWithWeekday        // "2024년 7월 23일 (화)"
    case timeOnly               // "오전 9:00"
    case shortDate              // "7월 23일"
    case shortDateWithWeekday   // "7월 23일 (화)"
    
    var format: String {
      switch self {
      case .full:
        return "yyyy년 M월 d일 (E) a h:mm"
      case .dateOnly:
        return "yyyy년 M월 d일"
      case .dateWithWeekday:
        return "yyyy년 M월 d일 (E)"
      case .timeOnly:
        return "a h:mm"
      case .shortDate:
        return "M월 d일"
      case .shortDateWithWeekday:
        return "M월 d일 (E)"
      }
    }
  }
  
  /// Date를 한국어 형식 문자열로 변환
  func toKoreanDateString(format: KoreanDateFormat = .full) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.dateFormat = format.format
    return formatter.string(from: self)
  }
}
