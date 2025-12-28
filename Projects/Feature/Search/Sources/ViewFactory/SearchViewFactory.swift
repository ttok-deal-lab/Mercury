//
//  SearchViewFactory.swift
//  Search
//
//  Created by 송하민 on 12/28/25.
//

import Foundation
import SwiftUI

import Domain
import Router

public struct SearchViewFactory: ViewFactory {

  private let auctionSalesListUsecase: AuctionSalesListUsecase
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  private let localStoargeUsecase: LocalStorageUsecase
  
  public init(
    auctionSalesListUsecase: AuctionSalesListUsecase,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    localStoargeUsecase: LocalStorageUsecase
  ) {
    self.auctionSalesListUsecase = auctionSalesListUsecase
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
    self.localStoargeUsecase = localStoargeUsecase
  }
  
  public func makeView(_ searchRoute: SearchRoute) -> some View {
    switch searchRoute.route {
    case .searchHome:
      SearchView(
        auctionSalesListUsecase: auctionSalesListUsecase,
        auctionSearchFilterUsecase: auctionSearchFilterUsecase,
        localStorageUsecase: localStoargeUsecase
      )
    }
  }
}
