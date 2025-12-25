//
//  AuctionBuildingUsageFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionBuildingUsageFilterView: View {
  @Environment(AuctionHomeModelData.self) private var modelData
  var onClosed: () -> Void

  @State private var reloadTask: Task<Void, Never>?

  private var selectedBuildTypeCodes: Binding<Set<String>> {
    Binding(
      get: { modelData.currentAuctionFilter.buildingTypeCodes ?? [] },
      set: { newValue in
        modelData.currentAuctionFilter.buildingTypeCodes = newValue
        reloadTask?.cancel()
        reloadTask = Task {
          try? await Task.sleep(nanoseconds: 300_000_000) // 0.3s
          guard !Task.isCancelled else { return }
          await modelData.loadAuctionSalesList()
        }
      }
    )
  }

  var body: some View {
    VStack(spacing: .zero) {
      header

      if let buildingTypes = modelData.auctionSearchFilter?.buildingTypes {
        ChipsContainerView(
          selectedChipIDs: selectedBuildTypeCodes,
          items: buildingTypes.map { ChipsType(id: $0.code, title: $0.displayName) }
        )
      }

      MercuryButton("\(modelData.filteredItemCount)개 매물 보기") {
        onClosed()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .onDisappear {
      reloadTask?.cancel()
    }
  }

  private var header: some View {
    HStack {
      Text("건물용도")
        .foregroundStyle(Asset.Colors.neutral.color)
        .fonts(.titleLargeBold)
      Spacer()
    }
    .padding(.vertical, 16)
    .padding(.horizontal, 20)
  }
}
