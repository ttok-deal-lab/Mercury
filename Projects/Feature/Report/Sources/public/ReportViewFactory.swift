//
//  ReportViewFactory.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import Foundation
import SwiftUI

import Router

public struct ReportViewFactory: ViewFactory {
  
  public init() { }
  
  public func makeView(_ reportRouter: ReportRoute) -> some View {
    switch reportRouter.route {
    case .crewLeaderApply:
      CrewLeaderApplyView()
    case .crewLeaderApplyDetail:
      CrewLeaderApplyDetailView()
    case .crewLeaderApplyComplete:
      CrewLeaderApplyCompleteView()
    case .createCrewRoom:
      CreateCrewFormView()
    }
  }
}
