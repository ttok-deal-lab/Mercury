//
//  AuctionCategories.swift
//  AppFoundation
//
//  Created by 송하민 on 10/6/24.
//

import Foundation

public enum AuctionCategories: String, CaseIterable, Identifiable {
  public var id: String {
    return self.rawValue
  }
  case house = "주택"
  case apartment = "아파트"
  case officetel = "오피스텔"
  case land = "토지"
  case factory = "공장"
  case store = "상가"
}
