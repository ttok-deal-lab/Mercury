//
//  AuctionFactory.swift
//  Auction
//
//  Created by 송하민 on 12/29/24.
//

import Foundation
import SwiftUI
import Combine

import Router
import Domain

public struct AuctionDetailViewFactory<MapView: MapViewable>: ViewFactory {
  
  private let auctionDetailUsecase: AuctionDetailUsecase
  
  public init(
    auctionDetailUsecase: AuctionDetailUsecase
  ) {
    self.auctionDetailUsecase = auctionDetailUsecase
  }
  
  public func makeView(
    _ auctionRoute: AuctionDetailRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch auctionRoute.route {
    case .auctionDetail(let auctionID):
      AuctionDetailView<MapView>(
        auctionID: auctionID,
        auctionDetailUsecase: self.auctionDetailUsecase,
        navigationStream: navigationStream
      )
    }
  }
}
