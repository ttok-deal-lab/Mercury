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
}
