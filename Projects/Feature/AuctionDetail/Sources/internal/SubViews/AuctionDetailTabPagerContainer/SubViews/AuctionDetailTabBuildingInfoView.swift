//
//  AuctionDetailTabBuildingInfoView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

// MARK: - Mock Model

struct BuildingDetailInfo: Equatable {
  var isIllegalBuilding: String          // "-", "해당", "해당없음" 등
  var totalFloorAreaText: String         // "110.52㎡ (33평)"
  var householdText: String              // "1동 | 63세대 | 19층"
  var completionDateText: String         // "1996년 10월 29일"
  var floorAreaRatioText: String         // "160%"
  var usageText: String                  // "주거"
  var structureText: String              // "콘크리트"
  var parkingTypeText: String            // "기계식"
  var elevatorText: String               // "있음" / "없음"
}

// MARK: - View

struct AuctionDetailTabBuildingInfoView: View {
  let info: BuildingDetailInfo
  var onTapLandInfo: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      header
        .padding(.bottom, 20)

      VStack(spacing: 20) {
        row(title: "불법건축물 여부", value: info.isIllegalBuilding)
        row(title: "연면적", value: info.totalFloorAreaText)
        row(title: "세대수", value: info.householdText)
        row(title: "준공년도", value: info.completionDateText)
        row(title: "용적률", value: info.floorAreaRatioText)
        row(title: "용도", value: info.usageText)
        row(title: "구조", value: info.structureText)
        row(title: "주차방식", value: info.parkingTypeText)
        row(title: "승강기", value: info.elevatorText)
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
  }

  private var header: some View {
    HStack(alignment: .center) {
      Text("건물 상세정보")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)

      Spacer()

      Button(action: onTapLandInfo) {
        Text("토지정보 바로보기")
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.horizontal, 10)
          .frame(height: 32)
          .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
              .fill(Asset.Colors.neutralWeak.color)
          )
      }
    }
  }

  private func row(title: String, value: String) -> some View {
    HStack(alignment: .center, spacing: 12) {
      Text(title)
        .fonts(.bodyMediumMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)

      Spacer()

      Text(value)
        .fonts(.bodyMediumMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .multilineTextAlignment(.trailing)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }

}
