//
//  ReportViewWrapperView.swift
//  MercuryApp
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import Domain
import Router
import Report
import Infrastructure

public struct ReportViewWrapperView: View, ReportViewable {
  
  let hostView: ReportView
  
  public init() {
    self.hostView = ReportView(
      crewLeaderUsecase: CrewLeaderUsecase(repository: CrewLeaderRepository())
    )
  }
  
  public var body: some View {
    hostView
  }
}
