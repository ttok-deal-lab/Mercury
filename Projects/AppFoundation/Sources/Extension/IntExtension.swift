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

  enum KoreanCurrencyStyle { case manWonOnly, full }

  private var decomposedKoreanUnits: (jo: Int, eok: Int, man: Int, won: Int) {
    let joUnit = 1_000_000_000_000 // 10^12
    let eokUnit =   10_000_000     // 10^8
    let manUnit =       10_000     // 10^4

    let absValue = Swift.abs(self)

    let jo = absValue / joUnit
    let afterJo = absValue % joUnit

    let eok = afterJo / eokUnit
    let afterEok = afterJo % eokUnit

    let man = afterEok / manUnit
    let won = afterEok % manUnit

    return (jo, eok, man, won)
  }

  // Decimal formatting for readability (e.g., 1,234)
  private func decimalString(_ value: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: NSNumber(value: value)) ?? String(value)
  }

  func toKoreanCurrency(style: KoreanCurrencyStyle = .full) -> String {
    let sign = self < 0 ? "-" : ""
    let parts = decomposedKoreanUnits

    switch style {
    case .manWonOnly:
      var components: [String] = []
      if parts.jo > 0 { components.append("\(decimalString(parts.jo))조") }
      if parts.eok > 0 { components.append("\(decimalString(parts.eok))억") }
      
      if !components.isEmpty {
        components.append("\(decimalString(parts.man))만")
      } else {
        components.append("\(decimalString(parts.man))만")
      }
      let result = components.joined(separator: " ") + "원"
      return sign + result

    case .full:
      var components: [String] = []
      if parts.jo > 0 { components.append("\(decimalString(parts.jo))조") }
      if parts.eok > 0 { components.append("\(decimalString(parts.eok))억") }
      if parts.man > 0 { components.append("\(decimalString(parts.man))만") }

      if parts.won == 0, !components.isEmpty {
        return sign + components.joined(separator: " ") + "원"
      }

      let wonString = decimalString(parts.won) + "원"

      if components.isEmpty {
        return sign + wonString
      } else {
        return sign + components.joined(separator: " ") + " " + wonString
      }
    }
  }

  var toKoreanManWon: String { toKoreanCurrency(style: .manWonOnly) }
  var toKoreanFullWon: String { toKoreanCurrency(style: .full) }
}

