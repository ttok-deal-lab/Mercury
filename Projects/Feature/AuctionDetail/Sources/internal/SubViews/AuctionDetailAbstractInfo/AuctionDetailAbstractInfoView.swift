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
  let isZzimed: Bool
  let zzimCount: Int
  let isLoadingZzim: Bool
  let onTapZzim: () -> Void
  
  var body: some View {
    VStack(spacing: .zero) {
      AuctionDetailAbstractTitleInfoView(
        auctionDetailInfo: auctionDetailInfo,
        isZzimed: isZzimed,
        zzimCount: zzimCount,
        isLoadingZzim: isLoadingZzim,
        onTapZzim: onTapZzim
      )
      
      AuctionDetailAbstractChipsView(auctionDetailInfo: auctionDetailInfo)
        .padding(.bottom, 16)
      
      AuctionDetailAbstractTopCardView(auctionDetailInfo: auctionDetailInfo)
    }
    .padding(20)
  }
}
