//
//  AuctionDetailAbstractInfoView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailAbstractInfoView: View {
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    VStack(spacing: .zero) {
      AuctionDetailAbstractTitleInfoView(auctionDetailInfo: auctionDetailInfo)
      
      AuctionDetailAbstractChipsView(auctionDetailInfo: auctionDetailInfo)
        .padding(.bottom, 16)
      
      AuctionDetailAbstractTopCardView(auctionDetailInfo: auctionDetailInfo)
    }
    .padding(20)
  }
}
