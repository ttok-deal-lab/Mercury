//
//  PlaceSearchResultRowView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import Domain
import UIComponent

/// 검색 결과 한 줄: 우편번호 + 뱃지, 도로명, 지번
struct PlaceSearchResultRowView: View {
  let address: AddressInfo
  let isServiceAvailable: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 8) {
        if let zipCode = address.zipCode {
          Text(zipCode)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        if isServiceAvailable {
          PlaceServiceBadgeView()
        }
      }
      
      if let road = address.roadAddress {
        line(label: L10n.reportPlaceRoad, value: road, isBold: true)
      }
      if let jibun = address.jibunAddress {
        line(label: L10n.reportPlaceJibun, value: jibun, isBold: false)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 20)
    .padding(.vertical, 20)
    .contentShape(Rectangle())
  }
  
  private func line(label: String, value: String, isBold: Bool) -> some View {
    HStack(alignment: .top, spacing: 8) {
      Text(label)
        .fonts(.bodyMicroBold)
        .foregroundStyle(Asset.Colors.neutral.color)
        .frame(width: 36, alignment: .leading)
      Text(value)
        .fonts(.bodyMicroRegular)
        .foregroundStyle(isBold ? Asset.Colors.neutral.color : Asset.Colors.neutralSubtle.color)
        .multilineTextAlignment(.leading)
    }
  }
}
