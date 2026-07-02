//
//  FilterItem.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI

import UIComponent

public enum AuctionFilterType: Identifiable, CaseIterable {
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
  
  public var id: Self { self }
  
  public var defaultTitle: String {
    switch self {
    case .certified: return L10n.commonCertifiedAuction
    case .buildingUsage: return L10n.auctionFilterBuildingUsage
    case .auctionStatus: return L10n.auctionFilterAuctionStatus
    case .price: return L10n.auctionFilterPrice
    case .bidWon: return L10n.auctionFilterBidWon
    }
  }
  
  public var isSingleToggle: Bool {
    self == .certified || self == .bidWon
  }
  
  public var isMultiSelectable: Bool {
    self == .buildingUsage || self == .auctionStatus
  }
  
}

public extension AuctionFilterType {
  var leftImage: Image? {
    return self == .certified ? Asset.Images.certified.image : nil
  }
  
  var isExpandable: Bool {
    switch self {
    case .buildingUsage, .auctionStatus, .price:
      return true
    case .certified, .bidWon:
      return false
    }
  }
}
