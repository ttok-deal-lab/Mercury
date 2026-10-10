//
//  CrewLeaderApplyView.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import AppFoundation
import UIComponent
import Router

public struct CrewLeaderApplyView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  
  public init() { }
  
  public var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar() {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      Text(L10n.reportLeaderApplyGuide)
        .fonts(.headingMiniBold)
        .foregroundStyle(Asset.Colors.neutral.color)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 19)
      
      Spacer()
      
      MercuryButton(L10n.reportLeaderApplySubmit) {
        coordinator.push(.report(ReportRoute(route: .crewLeaderApplyDetail)))
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 8)
    }
    .background(Asset.Colors.neutralWhite.color)
    .navigationBarBackButtonHidden()
  }
}
