//
//  AuctionDetailHistoryVIew.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailHistoryView: View {
  let auctionStartDateText: String
  let distributionDeadlineText: String
  let investigationDateText: String
  let items: [AuctionDetail.SalesDetail]

  @State private var isExpanded: Bool = false

  init(
    auctionStartDateText: String,
    distributionDeadlineText: String,
    investigationDateText: String,
    salesDetails: [AuctionDetail.SalesDetail]
  ) {
    self.auctionStartDateText = auctionStartDateText
    self.distributionDeadlineText = distributionDeadlineText
    self.investigationDateText = investigationDateText
    self.items = salesDetails
  }

  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text("경매 히스토리")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.bottom, 20)

      VStack(spacing: 20) {
        infoRow(title: "경매개시일", value: auctionStartDateText)
        infoRow(title: "배당종기일", value: distributionDeadlineText)
        infoRow(title: "현황조사일", value: investigationDateText)
      }
      .padding(.bottom, 20)

      historyCard(items: items)

      AuctionDetailHistoryExpandButton(isExpanded: isExpanded, isEnabled: items.count > 1) {
        withAnimation(.snappy) {
          isExpanded.toggle()
        }
      }
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 20)
  }

  private func infoRow(title: String, value: String) -> some View {
    HStack {
      Text(title)
        .font(.system(size: 14))
        .foregroundStyle(.secondary)
      Spacer()
      Text(value)
        .font(.system(size: 14, weight: .semibold))
    }
  }

  private func historyCard(items: [AuctionDetail.SalesDetail]) -> some View {
    let visible = isExpanded ? items : Array(items.prefix(1))

    return VStack(spacing: 0) {
      ForEach(Array(visible.enumerated()), id: \.offset) { idx, detail in
        AuctionDetailHistoryRowView(
          isLatest: idx == 0,
          roundText: roundText(for: detail, in: items),
          detail: detail
        )
        .padding(.horizontal, 14)
        .padding(.vertical, 12)

        if idx != visible.count - 1 {
          Divider()
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .inset(by: 0.5)
        .fill(Asset.Colors.neutralLight.color)
        .stroke(Asset.Colors.gray150.color, lineWidth: 1)
    )
    .overlay(alignment: .bottom) {
      if !isExpanded {
        LinearGradient(colors: [
          Color.white.opacity(0.01),
          Color.white
        ], startPoint: .top, endPoint: .bottom)
        .frame(height: 24, alignment: .bottom)
        .zIndex(1)
      }
    }
    .animation(.snappy, value: isExpanded)
  }

  /// 최신이 n차가 되도록 계산
  private func roundText(for detail: AuctionDetail.SalesDetail, in sortedItems: [AuctionDetail.SalesDetail]) -> String {
    // sortedItems는 최신->과거 순
    // 최신이 "n차", 과거로 갈수록 감소
    guard let index = sortedItems.firstIndex(where: { $0.timeStamp == detail.timeStamp && $0.location == detail.location && $0.leastSalesPrice == detail.leastSalesPrice }) else {
      return "-"
    }
    let n = sortedItems.count - index
    return "\(n)차"
  }
  
}

extension AuctionDetail.SalesDetail {
  /// 결과 텍스트
  var displayResult: String {
    switch result {
    case .failedBid: return "유찰"
    case .sold: return "낙찰"
    case .postponed: return "연기"
    case .canceled: return "취소"
    case .other(let v): return v
    }
  }

  /// 결과 색상
  var resultColor: Color {
    switch result {
    case .other(let v) where v.contains("불허"): return .red
    default: return .secondary
    }
  }
}
