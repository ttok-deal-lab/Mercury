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
  @State private var error: MercuryError?
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    auctionID: Int,
    auctionDetailUsecase: AuctionDetailUsecase,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) {
    self.navigationStream = navigationStream
    self.modelData = AuctionDetailModelData(
      auctionDetailUsecase: auctionDetailUsecase,
      auctionID: auctionID
    )
  }
  
  public var body: some View {
    if let item = modelData.auctionDetailItem {
      AuctionDetailMainContentView<MapView>(item: item)
    } else {
      ProgressView()
    }
    
  }
}

