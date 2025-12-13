//
//  TabPagerContainer.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

enum AuctionDetailTabTitles: String, CaseIterable, Identifiable, Hashable {
  case auction = "경매정보"
  case rights = "권리분석"
  case building = "건물정보"
  var id: Self { self }
}

struct AuctionDetailTabPagerContainer: View {
  @State private var selected: AuctionDetailTabTitles = .auction
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    UnderlineTabPager(
      tabs: AuctionDetailTabTitles.allCases,
      selected: $selected,
      spacing: 0,
      title: { $0.rawValue }
    ) { tab in
      switch tab {
      case .auction:
        AuctionDetailTabBriefCardView()
      case .rights:
        AuctionDetailTabRightsAnalysisView(report: auctionDetailInfo.conditionReport)
      case .building:
        Color.yellow
      }
    }
  }
}
