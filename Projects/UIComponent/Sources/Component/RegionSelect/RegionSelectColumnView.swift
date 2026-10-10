//
//  RegionSelectColumnView.swift
//  UIComponent
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

/// 지역 선택 시트의 한 열(시/도 목록 또는 구/군 목록). 선택된 칸은 검정 배경.
public struct RegionSelectColumnView: View {
  let items: [RegionSelectItem]
  let selectedID: String?
  let onSelect: (RegionSelectItem) -> Void
  
  public init(items: [RegionSelectItem], selectedID: String?, onSelect: @escaping (RegionSelectItem) -> Void) {
    self.items = items
    self.selectedID = selectedID
    self.onSelect = onSelect
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ForEach(items) { item in
        let isSelected = item.id == selectedID
        Button {
          onSelect(item)
        } label: {
          HStack(spacing: .zero) {
            Text(item.title)
              .fonts(.bodyLargeMedium)
              .foregroundColor(isSelected ? .white : Asset.Colors.neutral.color)
              .frame(height: 48)
              .padding(.horizontal, 20)
            
            Spacer()
          }
        }
        .background(isSelected ? Asset.Colors.neutral.color : .clear)
      }
      Spacer()
    }
  }
}
