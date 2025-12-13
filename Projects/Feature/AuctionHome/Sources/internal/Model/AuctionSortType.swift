//
//  AuctionSortType.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import Foundation

enum AuctionSortType: Identifiable, CaseIterable {
  var id: Self { self }
  
  /// 최신 등록순
  case recentRegistration
  /// 관심 많은 순
  case mostInterested
  /// 기일 임박 순
  case impendingDueDate
  /// 유찰 적은 순
  case lessBidding
  /// 가격 높은 순
  case highPrice
  /// 가격 낮은 순
  case lowPrice
}
