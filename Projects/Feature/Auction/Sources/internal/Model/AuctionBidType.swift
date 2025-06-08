//
//  BidType.swift
//  Domain
//
//  Created by 송하민 on 6/8/25.
//

/// 경매상태
enum BidType: Identifiable, CaseIterable {
  var id: Self { self }
  
  case all
  /// 신건
  case new
  /// 기일 변경 중
  case changingDueDate
  /// 유찰
  case outbid
}
