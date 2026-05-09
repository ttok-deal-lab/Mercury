//
//  AuctionDetailTabBriefCardView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

struct AuctionDetailTabBriefCardView: View {
  struct AuctionInfo: Identifiable {
    var id: String { title }
    let title: String
    let content: String
  }
  
  let auctionDetailInfo: AuctionDetail
  
  private var rows: [AuctionInfo] {
    var result: [AuctionInfo] = []

    let bidTypeText = auctionDetailInfo.bidType.displayName
    if !bidTypeText.isEmpty {
      result.append(.init(title: "입찰방식", content: bidTypeText))
    }
    result.append(contentsOf: [
      .init(title: "관할법원", content: auctionDetailInfo.court.name),
      .init(title: "매각장소", content: auctionDetailInfo.salesLocation),
      .init(title: "접수마감", content: auctionDetailInfo.salesReceptionDate.toKoreanDateString())
    ])

    let trimmedNote = auctionDetailInfo.salesNote.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedNote.isEmpty && trimmedNote != "null" {
      result.append(.init(title: "매각비고", content: trimmedNote))
    }

    return result
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("경매 정보")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)

      VStack(spacing: 20) {
        ForEach(rows) { row in
          auctionInfoRow(title: row.title, content: row.content)
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
  }

  private func auctionInfoRow(title: String, content: String) -> some View {
    HStack(alignment: .top, spacing: 12) {
      Text(title)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
      
      Spacer()
      
      Text(content)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .multilineTextAlignment(.trailing)
    }
  }
}
