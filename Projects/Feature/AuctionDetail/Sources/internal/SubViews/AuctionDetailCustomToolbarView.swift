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
  
  private var shareText: String {
    [
      auctionDetailInfo.salesAddress,
      "사건번호: \(auctionDetailInfo.salesNumber)"
    ]
    .joined(separator: "\n")
  }
  
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
      
      ShareLink(item: shareText) {
        Asset.Images.share.image
          .resizable()
          .frame(width: 28, height: 28)
      }
    }
    .frame(height: 60)
    .padding(.horizontal, 16)
  }
}
