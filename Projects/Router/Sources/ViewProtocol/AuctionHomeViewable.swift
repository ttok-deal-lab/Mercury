//
//  AuctionHomeViewable.swift
//  Router
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Domain

public protocol AuctionHomeViewable where Self: View {
  init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  )
}
