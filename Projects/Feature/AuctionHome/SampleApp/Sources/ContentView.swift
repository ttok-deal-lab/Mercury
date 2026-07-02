//
//  ContentView.swift
//  AuctionSampleApp
//
//  Created by 최수훈 on 11/6/24.
//

import SwiftUI

import AppFoundation
import AuctionHome
import Domain
import Infrastructure
import Router

struct ContentView: View {
  @StateObject private var coordinator = NavigationCoordinator<FeatureRoute>()

  private let auctionSalesListUsecase = SampleAuctionSalesListUsecase()
  private let auctionSearchFilterUsecase = SampleAuctionSearchFilterUsecase()
  private let auctionInterestUsecase = SampleAuctionInterestUsecase()
  private let localStorageUsecase = LocalStorageUsecase(repository: UserDefaultsStoreRepository())

  var body: some View {
    AuctionHomeView(
      auctionListUsecase: auctionSalesListUsecase,
      auctionSearchFilterUsecase: auctionSearchFilterUsecase,
      auctionInterestUsecase: auctionInterestUsecase,
      localStorageUsecase: localStorageUsecase
    )
    .environmentObject(coordinator)
  }
}
