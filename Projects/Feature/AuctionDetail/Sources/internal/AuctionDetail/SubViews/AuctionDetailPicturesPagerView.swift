//
//  AuctionDetailPicturesPagerView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailPicturesPagerView: View {
  let height: CGFloat
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    InfinitePager(items: auctionDetailInfo.salesPictures) { item in
      CachedAsyncImage(url: item.url) { image in
        image.resizable()
      } placeholder: {
        Color.gray
      }
      .frame(maxWidth: .infinity)
    }
    .frame(height: height)
  }
}
