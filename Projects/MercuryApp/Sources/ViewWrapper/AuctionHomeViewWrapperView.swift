//
//  AuctionHomeViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Auction
import Domain

public struct AuctionHomeViewWrapperView: View, AuctionHomeViewable {
  
  let hostView: AuctionHomeView
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>, auctionListUsecase: AuctionSalesListUsecasable) {
    self.hostView = AuctionHomeView(navigationStream: navigationStream, auctionListUsecase: auctionListUsecase)
  }
  
  public var body: some View {
    hostView
  }
}
