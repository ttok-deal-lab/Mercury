//
//  AuctionDetailSalesDetailView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailSalesBuildingDetailView: View {
  let salesItems: [AuctionDetail.SalesItemDetail]
  
  var body: some View {
    HStack(spacing: .zero) {
      VStack(alignment: .leading, spacing: .zero) {
        Text("건물 상세내역")
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.bottom, 20)
        
        ForEach(salesItems) { item in
          Text(item.content)
            .fonts(.bodySmallMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
        }
      }
      Spacer()
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 20)
  }
}
