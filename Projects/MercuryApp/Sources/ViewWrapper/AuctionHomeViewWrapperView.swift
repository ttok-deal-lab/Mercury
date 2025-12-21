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
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    auctionListUsecase: AuctionSalesListUsecasable,
    modelContext: ModelContext
  ) {
    self.hostView = AuctionHomeView(
      navigationStream: navigationStream,
      auctionListUsecase: auctionListUsecase,
      modelContext: modelContext
    )
  }
  
  public var body: some View {
    hostView
  }
}
