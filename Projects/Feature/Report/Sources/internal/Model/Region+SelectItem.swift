//
//  Region+SelectItem.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import Domain
import UIComponent

extension Region {
  /// 공용 지역 선택 시트(UIComponent) 에 넘길 값
  var selectItem: RegionSelectItem {
    RegionSelectItem(
      id: id,
      title: displayName,
      children: districts.map { RegionSelectItem(id: $0.id, title: $0.displayName) }
    )
  }
}
