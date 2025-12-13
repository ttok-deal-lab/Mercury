//
//  AuctionDetailTabRightsAnalysisView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

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
      HStack(spacing: 6) {
        Text("점유 관계")
          .font(.system(size: 20, weight: .semibold))
        Text("\(items.count)")
          .font(.system(size: 20, weight: .semibold))
          .foregroundStyle(.blue)
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

      Button { } label: {
        Text("현황조사서 보기")
          .font(.system(size: 15, weight: .semibold))
          .frame(maxWidth: .infinity)
          .padding(.vertical, 14)
      }
      .buttonStyle(.plain)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .stroke(Color.gray.opacity(0.25), lineWidth: 1)
      )
      .padding(.top, 6)
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
      HStack(spacing: 10) {
        ForEach(items.indices, id: \.self) { i in
          let item = items[i]
          OccupantChip(
            title: item.occupant,
            statusText: item.relation.displayName,
            isSelected: i == selectedIndex,
            badgeColor: item.relation.badgeColor
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
  let badgeColor: Color
  let onTap: () -> Void

  var body: some View {
    Button(action: onTap) {
      HStack(spacing: 10) {
        HStack(spacing: 6) {
          Text(title)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(isSelected ? .blue : .primary)

          if isSelected {
            Image(systemName: "checkmark")
              .font(.system(size: 12, weight: .bold))
              .foregroundStyle(.blue)
          }
        }

        Text(statusText)
          .font(.system(size: 13, weight: .semibold))
          .foregroundStyle(isSelected ? badgeColor : .secondary)
      }
      .padding(.horizontal, 14)
      .padding(.vertical, 12)
      .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .stroke(isSelected ? Color.blue : Color.gray.opacity(0.25), lineWidth: isSelected ? 1.5 : 1)
      )
    }
    .buttonStyle(.plain)
  }
}

private struct OccupantDetailCard: View {
  let item: AuctionDetail.ConditionReport.OccupationRelationReport

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 4) {
          Text(item.occupant)
            .font(.system(size: 18, weight: .semibold))

          if !item.occupiedPart.isEmpty {
            Text(item.occupiedPart)
              .font(.system(size: 13))
              .foregroundStyle(.secondary)
          }
        }

        Spacer()

        Text(item.relation.displayName)
          .font(.system(size: 14, weight: .semibold))
          .foregroundStyle(item.relation.badgeColor)
      }

      Divider().opacity(0.15)

      VStack(spacing: 10) {
        DetailRow(title: "대항력", value: "Mock", valueStyle: .mock)
        DetailRow(title: "ㄴ 전입신고일", value: item.movedAt.formattedKRDate)
        DetailRow(title: "ㄴ 점유상태", value: "Mock", valueStyle: .mock)

        DetailRow(title: "우선변제권", value: "Mock", valueStyle: .mock)
        DetailRow(title: "ㄴ 확정일자", value: item.confirmedAt.formattedKRDate)

        DetailRow(title: "배당요구", value: "Mock", valueStyle: .mock)
        DetailRow(title: "ㄴ 배당요구일", value: "Mock", valueStyle: .mock)
        DetailRow(title: "ㄴ 보증금", value: item.deposit.formattedWon)
        DetailRow(title: "ㄴ 월세", value: item.rental.formattedWon)
      }
      .padding(.top, 2)
    }
    .padding(16)
    .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
    .overlay(
      RoundedRectangle(cornerRadius: 14)
        .stroke(Color.gray.opacity(0.18), lineWidth: 1)
    )
  }
}

private enum DetailValueStyle { case normal, mock }

private struct DetailRow: View {
  let title: String
  let value: String
  var valueStyle: DetailValueStyle = .normal

  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(title)
        .font(.system(size: 13))
        .foregroundStyle(.secondary)

      Spacer(minLength: 12)

      Text(value)
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(valueStyle == .mock ? Color.orange : Color.primary)
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
  var badgeColor: Color {
    switch self {
    case .tenant: return .blue default: return .gray
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

private extension Int {
  var formattedWon: String {
    let f = NumberFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.numberStyle = .decimal
    let number = f.string(from: NSNumber(value: self)) ?? "\(self)"
    return "\(number)원"
  }
}
