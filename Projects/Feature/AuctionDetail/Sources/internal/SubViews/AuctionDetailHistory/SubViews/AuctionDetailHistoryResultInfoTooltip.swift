//
//  AuctionDetailHistoryResultInfoTooltip.swift
//  AuctionDetail
//
//  Created by DevLifter on 6/21/26.
//

import SwiftUI

import UIComponent
import Domain

/// 매각 히스토리 "결과"의 현재 기일종류 설명을 보여주는 popover 말풍선 콘텐츠.
/// 흰 배경/화살표는 시스템 popover가 그려주므로, 여기서는 설명 텍스트만 담는다.
struct AuctionDetailHistoryResultInfoTooltip: View {
  let result: AuctionDetail.SalesDetail.SalesResult

  var body: some View {
    if let description = result.infoDescription {
      Text(description)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: 240, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }
  }
}
