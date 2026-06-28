//
//  ContentView.swift
//  AuctionSampleApp
//
//  Created by 최수훈 on 11/6/24.
//

import SwiftUI

import AuctionDetail
import Domain

struct ContentView: View {

  var body: some View {
    AuctionDetailView<SampleMapView>(
      auctionID: SampleAuctionDetail.auctionID,
      auctionDetailUsecase: AuctionDetailUsecase(
        auctionDetailRepositorable: SampleAuctionDetailRepository()
      ),
      auctionInterestUsecase: SampleAuctionInterestUsecase()
    )
  }
}
