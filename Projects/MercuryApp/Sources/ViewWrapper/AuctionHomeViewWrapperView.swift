//
//  AuctionHomeViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import Combine
import SwiftUI

import Router
import AuctionHome
import Domain
import Infrastructure

public struct AuctionHomeViewWrapperView: View, AuctionHomeViewable {
  let hostView: AuctionHomeView
  
  public init() {
    self.hostView = AuctionHomeView(
      auctionListUsecase: AuctionSalesListUsecase(repository: AuctionSalesListRepository()),
      auctionSearchFilterUsecase: AuctionSearchFilterUsecase(repository: AuctionSearchFilterRepository()),
      localStorageUsecase: LocalStorageUsecase(repository: UserDefaultsStoreRepository())
    )
  }
  
  public var body: some View {
    hostView
  }
}
