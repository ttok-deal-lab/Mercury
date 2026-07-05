//
//  SearchRoute.swift
//  Router
//
//  Created by 송하민 on 12/28/25.
//

import Foundation

public struct SearchRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    case searchHome
    /// 딥링크로 진입 시 keyword 를 미리 넣고 결과까지 바로 보여준다.
    case searchResult(keyword: String)
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
