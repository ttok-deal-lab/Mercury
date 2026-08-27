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
  var id: Self { self }
}

struct AuctionDetailTabPagerContainerView: View {
  @State private var selected: AuctionDetailTabTitles = .auction
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    UnderlineTabPager(
      tabs: AuctionDetailTabTitles.allCases,
      selected: $selected,
      title: { $0.rawValue }
    ) { tab in
      switch tab {
      case .auction:
        AuctionDetailTabBriefCardView(auctionDetailInfo: auctionDetailInfo)
      }
    }
  }
}
