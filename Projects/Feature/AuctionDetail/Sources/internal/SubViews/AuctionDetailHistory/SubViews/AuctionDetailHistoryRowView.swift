//
//  AuctionHistoryRowView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

struct AuctionDetailHistoryRowView: View {
  let isLatest: Bool
  let roundText: String
  let detail: AuctionDetail.SalesDetail

  @State private var isResultInfoPresented = false

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 8) {
        if isLatest {
          Text("최신")
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.blue)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
              RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.blue.opacity(0.12))
            )
        }

        Text("\(roundText)  |  \(detail.timeStamp?.toKoreanDateString() ?? "-")")
          .fonts(.bodySmallBold)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)

        Spacer()

        // TODO: 이전 상세페이지 히스토리 없을 경우 숨기기
        Image(systemName: "chevron.right")
          .font(.system(size: 13, weight: .semibold))
          .foregroundStyle(.tertiary)
      }

      HStack {
        Text(L10n.auctionDetailHistoryMinPrice)
        Spacer()
        Text(detail.leastSalesPrice.map { $0.toKoreanCurrency() } ?? "-")
      }
      .fonts(.bodySmallMedium)
      .foregroundStyle(Asset.Colors.neutralSubtler.color)

      HStack(spacing: 6) {
        Text("결과")
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Spacer()

        Text(detail.displayResult)
          .fonts(.bodySmallBold)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)

        if detail.result.infoDescription != nil {
          Button {
            isResultInfoPresented = true
          } label: {
            Image(systemName: "info.circle")
              .font(.system(size: 13))
              .foregroundStyle(.tertiary)
          }
          .popover(isPresented: $isResultInfoPresented) {
            AuctionDetailHistoryResultInfoTooltip(result: detail.result)
              .presentationCompactAdaptation(.popover)
          }
        }
      }
    }
  }
  
  // TODO: result 에 따른 색상 처리
//  private var resultTextColor: Color {
//    switch detail.result {
//    case .inProgress: {
//      Asset.Colors.primary.color
//    case .
//    }
//    }
//  }
}
