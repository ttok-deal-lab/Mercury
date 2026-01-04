//
//  FeatureRoute.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import Foundation
import SwiftUI

public enum FeatureRoute: Hashable {
  case onboard(OnboardRoute)
  case auctionDetail(AuctionDetailRoute)
  case recentViewList(RecentViewRoute)
  case setting(SettingRoute)
  case terms(TermsRoute)
  case notification
  case search(SearchRoute)
  case networkConsole
}
