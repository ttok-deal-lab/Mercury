//
//  AuctionSalesCategory+DisplayName.swift
//  Domain
//
//  Created by DevLifter on 4/19/26.
//

import Foundation

public extension AuctionSalesCategory {
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
    case .housing:               return "주택"
    case .building:              return "건물"
    case .residential_building:  return "주거용건물"
    case .land_designation:      return "지목"
    case .building_site:         return "대지"
    }
  }

  /// 분류 계층의 깊이. 값이 클수록 구체적이다.
  private var specificity: Int {
    switch self {
    case .building, .land:
      return 0  // 대분류
    case .residential_building, .land_designation:
      return 1  // 중분류
    default:
      return 2  // 구체 용도
    }
  }

  /// 서버가 내려준 분류 배열에서 가장 구체적인 항목을 고른다.
  ///
  /// `salesCategories` 는 구체 용도와 상위 분류가 뒤섞여 오고 순서가 일정하지 않다.
  /// (`["VILLA", "BUILDING", "RESIDENTIAL_BUILDING"]` → 빌라,
  ///  `["BUILDING", "RESIDENTIAL_BUILDING"]` → 주거용건물)
  /// 깊이가 같으면 배열에서 먼저 온 항목을 쓴다.
  static func mostSpecific(in categories: [AuctionSalesCategory]) -> AuctionSalesCategory? {
    var mostSpecific: AuctionSalesCategory?
    for category in categories where category.specificity > (mostSpecific?.specificity ?? -1) {
      mostSpecific = category
    }
    return mostSpecific
  }
}
