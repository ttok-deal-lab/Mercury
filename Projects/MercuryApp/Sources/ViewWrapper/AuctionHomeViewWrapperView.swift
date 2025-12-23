//
//  AuctionHomeViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import Combine
import SwiftUI
import SwiftData

import Router
import AuctionHome
import Domain

public struct AuctionHomeViewWrapperView: View, AuctionHomeViewable {
  let hostView: AuctionHomeView
  
  public init(
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  ) {
    self.hostView = AuctionHomeView(
      auctionListUsecase: auctionListUsecase,
      auctionSearchFilterUsecase: auctionSearchFilterUsecase
    )
  }
  
  public var body: some View {
    hostView
  }
}
