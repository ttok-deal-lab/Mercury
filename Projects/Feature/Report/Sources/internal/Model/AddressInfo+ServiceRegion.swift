//
//  AddressInfo+ServiceRegion.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import Domain

extension AddressInfo {
  /// 주소의 시/도가 기준 지역과 같은지.
  /// 카카오는 "서울", 서버 지역명은 "서울특별시" 처럼 표기가 달라 앞 두 글자로 비교한다.
  func isInServiceRegion(_ regionName: String?) -> Bool {
    guard let regionName, let province, !province.isEmpty else { return false }
    return regionName.hasPrefix(String(province.prefix(2)))
  }
}
