//
//  AuctionDetailView.swift
//  Auction
//
//  Created by 송하민 on 11/1/25.
//

import SwiftUI
import Combine

import AppFoundation
import UIComponent
import Domain
import Router

public struct AuctionDetailView<MapView: MapViewable>: View {
  @State private var modelData: AuctionDetailModelData
  
  public init(
    auctionID: Int,
    auctionDetailUsecase: AuctionDetailUsecase
  ) {
    self.modelData = AuctionDetailModelData(
      auctionDetailUsecase: auctionDetailUsecase,
      auctionID: auctionID
    )
  }
  
  public var body: some View {
    AuctionDetailMainContentView<MapView>(modelData: $modelData)
  }
}

