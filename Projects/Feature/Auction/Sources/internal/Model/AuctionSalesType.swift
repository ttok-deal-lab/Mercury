//
//  SalesType.swift
//  Domain
//
//  Created by 송하민 on 6/8/25.
//

/// 건물용도
enum AuctionSalesType: String, Identifiable, CaseIterable {
  var id: Self { self }
  
  case all
  /// 아파트
  case apartment
  /// 빌라
  case villas
  /// 오피스텔
  case officetel
  /// 다가구주택
  case multifamiliy
}

extension AuctionSalesType {
  var title: String {
    switch self {
    case .all:
      "전체"
    case .apartment:
      "아파트"
    case .villas:
      "빌라(다세대, 연립)"
    case .officetel:
      "오피스텔"
    case .multifamiliy:
      "다가구주택"
    }
  }
}
