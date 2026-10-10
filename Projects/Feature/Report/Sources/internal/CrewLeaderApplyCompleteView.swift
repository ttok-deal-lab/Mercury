//
//  CrewLeaderApplyCompleteView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent
import Router

struct CrewLeaderApplyCompleteView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  
  init() { }
  
  var body: some View {
    VStack(spacing: .zero) {
      Spacer()
      
      ZStack {
        Circle()
          .fill(Asset.Colors.primaryLight.color)
          .frame(width: 120, height: 120)
        
        Circle()
          .fill(Asset.Colors.primary.color)
          .frame(width: 88, height: 88)
        
        Asset.Images.check.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundStyle(Asset.Colors.neutralWhite.color)
          .frame(width: 44, height: 44)
      }
      .padding(.bottom, 24)
      
      Text(L10n.reportLeaderApplyCompleteTitle)
        .fonts(.titleLargeBold)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.bottom, 8)
      
      Text(L10n.reportLeaderApplyCompleteDesc)
        .fonts(.bodySmallRegular)
        .foregroundStyle(Asset.Colors.neutralSubtle.color)
        .multilineTextAlignment(.center)
      
      Spacer()
      
      MercuryButton(L10n.commonConfirm) {
        coordinator.popToRoot()
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 8)
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Asset.Colors.neutralWhite.color)
    .navigationBarBackButtonHidden()
  }
}
