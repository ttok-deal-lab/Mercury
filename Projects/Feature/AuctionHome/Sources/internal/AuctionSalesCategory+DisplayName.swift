//
//  AuctionSalesCategory+DisplayName.swift
//  AuctionHome
//
//  Created by DevLifter on 4/19/26.
//

import Foundation

import Domain

extension AuctionSalesCategory {
  var displayName: String {
    switch self {
    case .apartment:             return "아파트"
    case .detached_house:        return "단독주택"
    case .multi_household:       return "다가구주택"
    case .row_house:             return "연립주택"
    case .multi_family:          return "다세대"
    case .villa:                 return "빌라"
    case .automobile:            return "자동차"
    case .heavy_equipment:       return "중기"
    case .land:                  return "대지"
    case .forest:                return "임야"
    case .farmland:              return "전답"
    case .commercial:            return "상가"
    case .office_tel:            return "오피스텔"
    case .neighborhood_facility: return "근린시설"
    case .other:                 return "기타"
    }
  }
}
