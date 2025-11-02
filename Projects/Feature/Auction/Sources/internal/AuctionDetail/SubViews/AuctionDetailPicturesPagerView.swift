//
//  AuctionDetailPicturesPagerView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import UIComponent
import Domain

// TODO: pager view 구현해야 함
struct AuctionDetailPicturesPagerView: View {
  let height: CGFloat
  let item: AuctionDetail
  
  var body: some View {
    CachedAsyncImage(
      url: item.salesPictures[0].imageUrl) { image in
        image.resizable()
      } placeholder: {
        Color.gray
      }
      .frame(maxWidth: .infinity)
      .frame(height: height)
  }
}
