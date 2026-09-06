//
//  IntExtension.swift
//  AppFoundation
//
//  Created by 송하민 on 11/2/25.
//

import Foundation

public extension Int {
  var toKoreanWon: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale(identifier: "ko_KR")
    
    let priceInWon = NSNumber(value: self)
    return formatter.string(from: priceInWon) ?? "\(self)"
  }
  
  enum KoreanCurrencyStyle {
    case manWonOnly // 만 원 단위까지만 표시 (천 원 단위 절사)
    case full       // 전체 표시
  }
  
  private var decomposedKoreanUnits: (jo: Int, eok: Int, man: Int, won: Int) {
    let joUnit = 1_000_000_000_000
    let eokUnit = 100_000_000
    let manUnit = 10_000
    
    let absValue = Swift.abs(self)
    
    let jo = absValue / joUnit
    let afterJo = absValue % joUnit
    
    let eok = afterJo / eokUnit
    let afterEok = afterJo % eokUnit
    
    let man = afterEok / manUnit
    let won = afterEok % manUnit
    
    return (jo, eok, man, won)
  }
  
  private func decimalString(_ value: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: value)) ?? String(value)
  }
  
  func toKoreanCurrency(style: KoreanCurrencyStyle = .full) -> String {
    // 0원 처리
    if self == 0 { return "0원" }
    
    let sign = self < 0 ? "-" : ""
    let parts = decomposedKoreanUnits
    var components: [String] = []
    
    // 1. 조, 억 단위는 공통적으로 값이 있을 때만 추가
    if parts.jo > 0 { components.append("\(decimalString(parts.jo))조") }
    if parts.eok > 0 { components.append("\(decimalString(parts.eok))억") }
    
    switch style {
    case .manWonOnly:
      if parts.man > 0 {
        components.append("\(decimalString(parts.man))만")
      }
      
      if components.isEmpty {
        return sign + decimalString(parts.won) + "원"
      }
      
      return sign + components.joined(separator: " ") + "원"
      
    case .full:
      if parts.man > 0 { components.append("\(decimalString(parts.man))만") }
      
      // 원 단위 처리
      if parts.won > 0 {
        // 앞선 단위가 하나라도 있으면 띄어쓰기 후 원 단위 표시
        // 예: 1억 500원
        let separator = components.isEmpty ? "" : " "
        return sign + components.joined(separator: " ") + separator + "\(decimalString(parts.won))원"
      } else {
        // 딱 떨어지는 금액 (예: 1억 원)
        return sign + components.joined(separator: " ") + "원"
      }
    }
  }
  
  var toKoreanManWon: String { toKoreanCurrency(style: .manWonOnly) }
  var toKoreanFullWon: String { toKoreanCurrency(style: .full) }
  
  /// 검색 결과 건수 표기. 10,000건 이상은 "9999+" 로 축약한다.
  var toCappedCountText: String {
    let maxDisplayCount = 9_999
    return self > maxDisplayCount ? "\(maxDisplayCount)+" : "\(self)"
  }
}

