//
//  RegionSelectSheetView.swift
//  UIComponent
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

/// 홈 지역 필터와 크루 만들기 지역 선택이 함께 쓰는 지역 선택 시트.
/// 왼쪽 열에서 시/도를 고르면 오른쪽 열에 그 하위 구/군이 나온다.
public struct RegionSelectSheetView: View {
  let regions: [RegionSelectItem]
  let selectedRegionID: String?
  let selectedDistrictID: String?
  let onSelectRegion: (RegionSelectItem) -> Void
  let onSelectDistrict: (RegionSelectItem) -> Void
  let onApply: () -> Void
  
  public init(
    regions: [RegionSelectItem],
    selectedRegionID: String?,
    selectedDistrictID: String?,
    onSelectRegion: @escaping (RegionSelectItem) -> Void,
    onSelectDistrict: @escaping (RegionSelectItem) -> Void,
    onApply: @escaping () -> Void
  ) {
    self.regions = regions
    self.selectedRegionID = selectedRegionID
    self.selectedDistrictID = selectedDistrictID
    self.onSelectRegion = onSelectRegion
    self.onSelectDistrict = onSelectDistrict
    self.onApply = onApply
  }
  
  private var selectedRegion: RegionSelectItem? {
    regions.first { $0.id == selectedRegionID }
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      HStack(spacing: .zero) {
        Text(L10n.searchFilterLocation)
          .fonts(.titleLargeBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        
        Spacer()
        
        Button {
          onApply()
        } label: {
          Text(L10n.searchFilterApply)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
      }
      .padding(.top, 50)
      .padding(.bottom, 16)
      .padding(.horizontal, 20)
      
      Rectangle()
        .foregroundStyle(Asset.Colors.neutralLight.color)
        .frame(height: 1)
        .frame(maxWidth: .infinity)
      
      ScrollView(.vertical) {
        HStack(alignment: .top, spacing: .zero) {
          RegionSelectColumnView(items: regions, selectedID: selectedRegionID, onSelect: onSelectRegion)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
          
          if let selectedRegion {
            RegionSelectColumnView(items: selectedRegion.children, selectedID: selectedDistrictID, onSelect: onSelectDistrict)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.vertical, 16)
          }
        }
      }
    }
  }
}
