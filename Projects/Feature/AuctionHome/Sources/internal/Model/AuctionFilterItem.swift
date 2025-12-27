//
//  FilterItem.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI

import UIComponent

enum AuctionFilterType: Identifiable, CaseIterable {
  /// 인증매물
  case certified
  /// 건물용도
  case buildingUsage
  /// 경매상태
  case auctionStatus
  /// 가격
  case price
  /// 낙찰
  case bidWon
  
  var id: Self { self }
  
  var defaultTitle: String {
    switch self {
    case .certified: return L10n.commonCertifiedAuction
    case .buildingUsage: return L10n.auctionFilterBuildingUsage
    case .auctionStatus: return L10n.auctionFilterAuctionStatus
    case .price: return L10n.auctionFilterPrice
    case .bidWon: return L10n.auctionFilterBidWon
    }
  }
  
  var isSingleToggle: Bool {
    self == .certified || self == .bidWon
  }
  
  var isMultiSelectable: Bool {
    self == .buildingUsage || self == .auctionStatus
  }
  
}

struct FilterItem: Identifiable {
  let type: AuctionFilterType
  var selectedValues: [String] = []
  var exclusiveValue: String? = nil
  
  var id: AuctionFilterType { type }
  
  var isActive: Bool {
    !selectedValues.isEmpty || exclusiveValue != nil
  }
  
  var isExpandable: Bool {
    self.type == .buildingUsage || self.type == .auctionStatus || self.type == .price
  }
  
  var displayTitle: String {
    if type.isSingleToggle {
      return type.defaultTitle
    }
    
    if selectedValues.isEmpty && exclusiveValue == nil {
      return type.defaultTitle
    } else {
      if type.isMultiSelectable {
        if selectedValues.count == 1 {
          return selectedValues.first!
        } else {
          return L10n.auctionFilterMultiSelect(selectedValues.first!, selectedValues.count - 1)
        }
      } else {
        if let exclusiveValue {
          return exclusiveValue
        } else {
          return type.defaultTitle
        }
      }
    }
  }
}
