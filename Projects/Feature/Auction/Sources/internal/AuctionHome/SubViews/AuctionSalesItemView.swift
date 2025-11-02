//
//  AuctionItemView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import Domain
import UIComponent

struct AuctionSalesItemView: View {
  var auctionSalesItemURL: URL?
  var appraisalPrice: String
  var locationBuildingName: String
  var category: [AuctionSalesCategory?]
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: 16) {
        CachedAsyncImage(url: auctionSalesItemURL, content: { image in
          image.resizable()
        }) {
          Asset.Colors.gray150.color
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
        VStack(alignment: .leading, spacing: 2) {
          Text(L10n.commonWon(appraisalPrice))
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyLargeBold)
          
          Text("\(locationBuildingName)")
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyMicroMedium)
            .multilineTextAlignment(.leading)
        }
        
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      
    }
  }
}
