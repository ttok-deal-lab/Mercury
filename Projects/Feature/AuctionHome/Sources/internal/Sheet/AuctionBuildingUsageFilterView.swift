//
//  AuctionBuildingUsageFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

struct AuctionBuildingUsageFilterView: View {
  @Environment(AuctionHomeModelData.self) private var modelData
  var onClosed: () -> Void

  @State private var reloadTask: Task<Void, Never>?

  /// 서버 `buildType` enum 의 "전체" 코드
  static let allBuildingTypeCode = "ALL"

  private var selectedBuildTypeCodes: Binding<Set<String>> {
    Binding(
      get: { modelData.currentAuctionFilter.buildingTypeCodes ?? [] },
      set: { newValue in
        let current = modelData.currentAuctionFilter.buildingTypeCodes ?? []
        modelData.currentAuctionFilter.buildingTypeCodes = Self.resolvingAllExclusivity(
          current: current,
          new: newValue
        )
        reloadTask?.cancel()
        reloadTask = Task {
          try? await Task.sleep(nanoseconds: 500_000_000) // 0.5
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

      MercuryButton("\(modelData.filteredItemCount.toCappedCountText)개 매물 보기") {
        onClosed()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .onDisappear {
      reloadTask?.cancel()
    }
  }

  /// "전체" 와 개별 항목은 동시에 선택될 수 없다.
  /// - 개별 항목이 선택된 상태에서 "전체" 를 새로 고르면 나머지를 모두 해제한다.
  /// - "전체" 가 선택된 상태에서 개별 항목을 새로 고르면 "전체" 를 해제한다.
  /// - 해제만 일어난 경우에는 그대로 반영한다.
  static func resolvingAllExclusivity(current: Set<String>, new: Set<String>) -> Set<String> {
    let added = new.subtracting(current)
    guard !added.isEmpty else { return new }

    if added.contains(allBuildingTypeCode) {
      return [allBuildingTypeCode]
    }
    if new.contains(allBuildingTypeCode) {
      return new.subtracting([allBuildingTypeCode])
    }
    return new
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
