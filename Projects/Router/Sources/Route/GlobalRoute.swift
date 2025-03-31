//
//  GlobalRoute.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import Foundation
import SwiftUI

public enum GlobalRoute: Hashable {
  case signIn(SignInRoute)
  case tutorial(TutorialRoute)
  case auction(AuctionRoute)
}
