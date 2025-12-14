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
        AuctionDetailTabBriefCardView()
      case .rights:
        AuctionDetailTabRightsAnalysisView(report: auctionDetailInfo.conditionReport)
      case .building:
        AuctionDetailTabBuildingInfoView(
          info: .init( // 백엔드 데이터가 없다. 대충 낋여본다
            isIllegalBuilding: "-",
            totalFloorAreaText: "110.52㎡ (33평)",
            householdText: "1동 | 63세대 | 19층",
            completionDateText: "1996년 10월 29일",
            floorAreaRatioText: "160%",
            usageText: "주거",
            structureText: "콘크리트",
            parkingTypeText: "기계식",
            elevatorText: "있음"
          ),
          onTapLandInfo: {
            print("토지정보 바로보기 tapped")
          }
        )
      }
    }
  }
}
