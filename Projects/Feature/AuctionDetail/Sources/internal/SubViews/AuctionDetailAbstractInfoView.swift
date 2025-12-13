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
      AbstractTitleInfoView(auctionDetailInfo: auctionDetailInfo)
      
      AbstractChipsView(auctionDetailInfo: auctionDetailInfo)
        .padding(.bottom, 16)
      
      AbstractTopCardView(auctionDetailInfo: auctionDetailInfo)
      
      dividerView().padding(.top, 20)
      
      
      
    }
    .padding(20)
   
  }
  
  // MARK: - SubView methods
  
  private func dividerView(height: CGFloat = 10) -> some View {
    Divider()
      .frame(height: height)
      .foregroundStyle(Asset.Colors.neutralWeak.color)
  }
}
