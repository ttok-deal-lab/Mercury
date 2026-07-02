//
//  AuctionDetailTabRightsAnalysisView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

struct AuctionDetailTabRightsAnalysisView: View {
  @State private var selectedIndex: Int = 0
  let rightsAnalysis: [AuctionDetail.RightsAnalysis]

  init(rightsAnalysis: [AuctionDetail.RightsAnalysis]) {
    self.rightsAnalysis = rightsAnalysis
  }

  var body: some View {
    let items = rightsAnalysis

    let safeIndex = min(max(selectedIndex, 0), max(items.count - 1, 0))
    let selected = items.isEmpty ? nil : items[safeIndex]

    VStack(alignment: .leading, spacing: 12) {
      HStack(spacing: 4) {
        Text("임차인")
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        Text("\(items.count)")
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.primary.color)
      }

      if items.isEmpty {
        Text("권리분석 정보가 없습니다")
          .font(.system(size: 14))
          .foregroundStyle(.secondary)
          .padding(.top, 8)
      } else {
        OccupantChipRow(
          items: items,
          selectedIndex: $selectedIndex
        )

        if let selected {
          OccupantDetailCard(item: selected)
        }
      }
    }
    .padding(16)
    .onAppear { selectedIndex = 0 }
    .onChange(of: rightsAnalysis.count) { _, _ in
      selectedIndex = 0
    }
  }
}

private struct OccupantChipRow: View {
  let items: [AuctionDetail.RightsAnalysis]
  @Binding var selectedIndex: Int

  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 16) {
        ForEach(items.indices, id: \.self) { i in
          let item = items[i]
          OccupantChip(
            title: item.name,
            statusText: item.occupationStatus,
            isSelected: i == selectedIndex
          ) {
            withAnimation(.snappy) { selectedIndex = i }
          }
        }
      }
      .padding(.vertical, 2)
      .padding(.horizontal, 1)
    }
    .scrollIndicators(.hidden)
  }
}

private struct OccupantChip: View {
  let title: String
  let statusText: String
  let isSelected: Bool
  let onTap: () -> Void

  var body: some View {
    Button(action: onTap) {
      HStack(spacing: 10) {
        HStack(spacing: 6) {
          Text(title)
            .fonts(.bodyMediumBold)
            .foregroundStyle(Asset.Colors.neutral.color)

          if isSelected {
            Image(systemName: "checkmark")
              .font(.system(size: 12, weight: .bold))
              .foregroundStyle(.blue)
          }
        }

        Spacer()
        Text(statusText)
          .fonts(.bodyMediumBold)
          .foregroundStyle(isSelected ? Asset.Colors.primary.color : Asset.Colors.neutralSubtler.color)
      }
      .padding(16)
      .shadows(.shadowMedium)
    }
    .frame(width: 210, height: 54)
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(
          isSelected ? Asset.Colors.primary.color : Asset.Colors.neutralMuted.color,
          lineWidth: 1
        )
    )
  }
}

private struct OccupantDetailCard: View {
  let item: AuctionDetail.RightsAnalysis

  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {

      HStack(alignment: .top) {
        Text(item.name)
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)

        Spacer()

        Text(item.occupationStatus)
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.primary.color)
      }
      .padding(16)

      VStack(spacing: 12) {
        // 대항력
        DetailRow(title: "대항력", value: item.hasOppositionRight, displayType: .titler)
        DetailRow(title: "ㄴ 전입신고일", value: item.moveInReportDate)
        DetailRow(title: "ㄴ 점유상태", value: item.occupationStatus)

        // 우선변제권
        DetailRow(title: "우선변제권", value: item.priorityRepaymentRight, displayType: .titler)
        DetailRow(title: "ㄴ 확정일자", value: item.fixedDate)

        // 배당요구
        DetailRow(title: "배당요구", value: item.dividendRequest, displayType: .titler)
        DetailRow(title: "ㄴ 배당요구일", value: item.dividendRequestDate)
        DetailRow(title: "ㄴ 보증금", value: item.deposit.toKoreanWon)
        DetailRow(title: "ㄴ 월세", value: item.monthlyRent.toKoreanWon)
      }
      .padding(16)
      .background(Asset.Colors.neutralLight.color)
    }
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(
          Asset.Colors.gray150.color,
          lineWidth: 1
        )
    )
  }
}

private enum DetailRowDisplayType {
  case titler
  case subtler

  var font: MercuryFont {
    switch self {
    case .titler: .bodySmallBold
    case .subtler: .bodySmallMedium
    }
  }
}

private struct DetailRow: View {
  let title: String
  let value: String
  var displayType: DetailRowDisplayType = .subtler

  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(title)
        .fonts(displayType.font)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)

      Spacer()

      Text(value)
        .fonts(displayType.font)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .multilineTextAlignment(.trailing)
    }
  }
}
