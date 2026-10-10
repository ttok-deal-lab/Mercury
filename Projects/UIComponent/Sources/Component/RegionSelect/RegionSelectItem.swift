//
//  RegionSelectItem.swift
//  UIComponent
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

/// 지역(시/도) 또는 하위 구/군 한 칸. UIComponent 는 Domain 을 모르므로 화면이 Domain 모델을 이 값으로 바꿔 넘긴다.
public struct RegionSelectItem: Identifiable, Equatable {
  public let id: String
  public let title: String
  public let children: [RegionSelectItem]
  
  public init(id: String, title: String, children: [RegionSelectItem] = []) {
    self.id = id
    self.title = title
    self.children = children
  }
}
