//
//  Region.swift
//  AppFoundation
//
//  Created by 송하민 on 10/6/24.
//

/// 특별시, 광역시, 도 단위의 지역
public enum Region: String, CaseIterable, Identifiable {
  public var id: String {
    return self.rawValue
  }
  case seoul
  case gyeonggi
  case incheon
  case gangwon
  case chungcheong_north
  case chungcheong_south
  case daejeon
  case gyeongsang_north
  case gyeongsang_south
  case daegu
  case ulsan
  case busan
  case jeolla_north
  case jeolla_south
  case gwangju
  case jeju
  
  public var actualName: String {
    switch self {
    case .seoul: return "서울특별시"
    case .gyeonggi: return "경기도"
    case .incheon: return "인천광역시"
    case .gangwon: return "강원도"
    case .chungcheong_north: return "충청남도"
    case .chungcheong_south: return "충청북도"
    case .daejeon: return "대전광역시"
    case .gyeongsang_north: return "경상북도"
    case .gyeongsang_south: return "경상남도"
    case .daegu: return "대구광역시"
    case .ulsan: return "울산광역시"
    case .busan: return "부산광역시"
    case .jeolla_north: return "전라북도"
    case .jeolla_south: return "전라남도"
    case .gwangju: return "광주광역시"
    case .jeju: return "제주도"
    }
  }
}
