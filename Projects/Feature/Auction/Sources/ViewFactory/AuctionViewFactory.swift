//
//  AuctionFactory.swift
//  Auction
//
//  Created by 송하민 on 12/29/24.
//

import Foundation
import SwiftUI

import Coordinator

public struct AuctionViewFactory {
  
  public init() {}
  
  @ViewBuilder
  public static func makeView(_ auctionRoute: AuctionRoute) -> some View {
    switch auctionRoute.route {
    case let .recommendAuction(id):
      AuctionDetailView(auctionId: id)
    }
  }
}
