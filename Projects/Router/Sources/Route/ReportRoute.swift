//
//  ReportRoute.swift
//  Router
//
//  Created by 최수훈 on 10/8/26.
//

import Foundation

public struct ReportRoute: Hashable {
  public private(set) var route: Route
  
  public init(route: Route) {
    self.route = route
  }
  
  public enum Route: Hashable {
    /// 크루장 신청 페이지
    case crewLeaderApply
    /// 크루장 신청 디테일 페이지
    case crewLeaderApplyDetail
    /// 크루장 신청 완료 페이지
    case crewLeaderApplyComplete
    ///
    case createCrewRoom
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}
