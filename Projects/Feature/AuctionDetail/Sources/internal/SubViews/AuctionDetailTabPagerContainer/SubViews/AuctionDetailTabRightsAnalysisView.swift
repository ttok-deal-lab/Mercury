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
  let report: AuctionDetail.ConditionReport

  init(report: AuctionDetail.ConditionReport) {
    self.report = report
  }

  var body: some View {
    let items = report.occupationRelationReports

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
        Text("점유자 정보가 없습니다")
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
    .onChange(of: report.occupationRelationReports.count) { _, _ in
      selectedIndex = 0
    }
  }
}

private struct OccupantChipRow: View {
  let items: [AuctionDetail.ConditionReport.OccupationRelationReport]
  @Binding var selectedIndex: Int

  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 16) {
        ForEach(items.indices, id: \.self) { i in
          let item = items[i]
          OccupantChip(
            title: item.occupant,
            statusText: item.relation.displayName,
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
  let item: AuctionDetail.ConditionReport.OccupationRelationReport

  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 4) {
          Text(item.occupant)
            .fonts(.titleMediumBold)
            .foregroundStyle(Asset.Colors.neutral.color)

          if !item.occupiedPart.isEmpty {
            Text(item.occupiedPart)
              .fonts(.bodyMicroMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
          }
        }

        Spacer()

        Text(item.relation.displayName)
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.primary.color)
      }
      .padding(16)

      VStack(spacing: 12) {
        DetailRow(title: "소재지", value: item.address)
        if !item.purpose.displayName.isEmpty {
          DetailRow(title: "용도", value: item.purpose.displayName)
        }
        if !item.duration.isEmpty {
          DetailRow(title: "점유기간", value: item.duration)
        }
        DetailRow(title: "전입신고일", value: item.movedAt.formattedKRDate)
        DetailRow(title: "확정일자", value: item.confirmedAt.formattedKRDate)
        DetailRow(title: "보증금", value: item.deposit.toKoreanWon)
        DetailRow(title: "월세", value: item.rental.toKoreanWon)
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

private extension AuctionDetail.ConditionReport.OccupationRelationReport.OccupantRelation {
  var displayName: String {
    switch self {
    case .debtor: "채무자"
    case .tenant: "임차인"
    case .owner: "소유자"
    case .other(let v): v
    }
  }
}

private extension AuctionDetail.ConditionReport.OccupationRelationReport.OccupationPurpose {
  var displayName: String {
    switch self {
    case .residential:
      return "주거"
    case .commercial:
      return "상업"
    case .office:
      return "사무실"
    case .other(let value):
      return value
    }
  }
}

private extension Date {
  var formattedKRDate: String {
    let f = DateFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.timeZone = TimeZone(identifier: "Asia/Seoul")
    f.dateFormat = "yyyy.MM.dd"
    return f.string(from: self)
  }
}
