//
//  ReportView.swift
//  Report
//
//  Created by 송하민 on 4/13/25.
//

import Foundation
import SwiftUI
import Combine

import AppFoundation
import UIComponent
import Router

public struct ReportView: View {
  @State private var modelData = ReportModelData()
  
  public init() { }
  
  public var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar(title: L10n.reportTitle, titleFont: .titleLargeBold)
        .padding(.horizontal, 20)
      
      ScrollView(.vertical) {
        VStack(spacing: .zero) {
          ReportCrewApplyBannerView {
            modelData.applyCrewLeader()
          }
          
          Rectangle()
            .fill(Asset.Colors.neutralWeak.color)
            .frame(height: 8)
          
          crewSection()
        }
      }
    }
    .background(Asset.Colors.neutralWhite.color)
    .loading(modelData.isLoading)
    .alert(error: $modelData.error)
    .onLoad {
      Task {
        await modelData.onAppear()
      }
    }
  }
  
  // MARK: - private method
  
  private func crewSection() -> some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(L10n.reportOngoingCrew)
        .fonts(.bodyMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)
      
      ReportCrewFilterView(selectedFilter: modelData.selectedFilter) { filter in
        modelData.selectedFilter = filter
      }
      
      LazyVStack(spacing: 16) {
        ForEach(modelData.filteredCrewList) { item in
          ReportCrewItemView(item: item)
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
