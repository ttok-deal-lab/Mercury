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
  case auction(AuctionRoute)
  case networkConsole
}
