//
//  FilterItem.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI

enum AuctionFilterType: Identifiable, CaseIterable {
  case certified
  case buildingUsage
  case auctionStatus
  case price
  case bidWon
  
  var id: Self { self }
  
  var defaultTitle: String {
    switch self {
    case .certified: return "인증매물"
    case .buildingUsage: return "건물용도"
    case .auctionStatus: return "경매상태"
    case .price: return "가격"
    case .bidWon: return "낙찰"
    }
  }
  
  var isSingleToggle: Bool {
    self == .certified || self == .bidWon
  }
}

struct FilterItem: Identifiable {
  let type: AuctionFilterType
  var selectedValues: [String] = []
  
  var id: AuctionFilterType { type }
  
  var isActive: Bool {
    !selectedValues.isEmpty
  }
  
  var isExpandable: Bool {
    self.type == .buildingUsage || self.type == .auctionStatus || self.type == .price
  }
  
  var displayTitle: String {
    if type.isSingleToggle {
      return type.defaultTitle
    }
    
    if selectedValues.isEmpty {
      return type.defaultTitle
    } else if selectedValues.count == 1 {
      return selectedValues.first!
    } else {
      return "\(selectedValues.first!) 외 \(selectedValues.count - 1)"
    }
  }
}
