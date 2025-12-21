//
//  AuctionHomeViewable.swift
//  Router
//
//  Created by 송하민 on 4/13/25.
//

import Combine
import SwiftData
import SwiftUI

import Domain

public protocol AuctionHomeViewable where Self: View {
  init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    modelContext: ModelContext)
}
