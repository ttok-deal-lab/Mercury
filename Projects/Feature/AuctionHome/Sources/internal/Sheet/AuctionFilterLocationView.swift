//
//  AuctionFilterLocationSheetView.swift
//  AuctionHome
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

import UIComponent
import Domain

/// 홈 지역 필터. UI 는 UIComponent 의 공용 지역 선택 시트를 쓰고, 선택 결과만 필터 모델에 반영한다.
struct AuctionFilterLocationView: View {
  @Binding var modelData: AuctionHomeModelData
  
  var onApplied: (() -> Void)
  
  private var regions: [Region] {
    modelData.auctionSearchFilter?.regions ?? []
  }
  
  var body: some View {
    RegionSelectSheetView(
      regions: regions.map(\.selectItem),
      selectedRegionID: modelData.currentAuctionFilter.region?.id,
      selectedDistrictID: modelData.currentAuctionFilter.district?.id,
      onSelectRegion: { item in
        modelData.currentAuctionFilter.region = regions.first { $0.id == item.id }
        modelData.currentAuctionFilter.district = nil
      },
      onSelectDistrict: { item in
        modelData.currentAuctionFilter.district = modelData.currentAuctionFilter.region?.districts.first { $0.id == item.id }
      },
      onApply: onApplied
    )
  }
}

private extension Region {
  var selectItem: RegionSelectItem {
    RegionSelectItem(
      id: id,
      title: displayName,
      children: districts.map { RegionSelectItem(id: $0.id, title: $0.displayName) }
    )
  }
}
