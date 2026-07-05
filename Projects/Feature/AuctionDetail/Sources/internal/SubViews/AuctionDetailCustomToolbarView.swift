//
//  AuctionDetailCustomToolbarView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import Domain
import UIComponent

struct AuctionDetailCustomToolbarView: View {
  @Environment(\.dismiss) var dismiss
  let auctionDetailInfo: AuctionDetail

  var body: some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Asset.Images.arrowLeft.image
          .resizable()
          .frame(width: 28, height: 28)
      }

      Text(auctionDetailInfo.salesAddress)
        .fonts(.bodyLargeBold)
        .lineLimit(1)
        .truncationMode(.tail)

      Spacer()

      Button {
        AuctionKakaoShareSender.send(auction: auctionDetailInfo)
      } label: {
        Asset.Images.share.image
          .resizable()
          .frame(width: 28, height: 28)
      }
    }
    .frame(height: 60)
    .padding(.horizontal, 16)
  }
}
