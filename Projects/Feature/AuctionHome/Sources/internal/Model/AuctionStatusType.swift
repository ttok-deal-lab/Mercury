//
//  BidType.swift
//  Domain
//
//  Created by 송하민 on 6/8/25.
//

/// 경매상태
enum AuctionStatusType: String, Identifiable, CaseIterable {
  var id: Self { self }
  
  case all
  /// 신건
  case new
  /// 기일 변경 중
  case changingDueDate
  /// 유찰 1회 이상
  case outbidOver1
  /// 유찰 2회 이상
  case outbidOver2
  /// 유찰 3회 이상
  case outbidOver3
  
  var title: String {
    switch self {
    case .all:
      "전체"
    case .new:
      "신건"
    case .changingDueDate:
      "기일변경중"
    case .outbidOver1:
      "유찰 1회 이상"
    case .outbidOver2:
      "유찰 2회 이상"
    case .outbidOver3:
      "유찰 3회 이상"
      
    }
  }
}
