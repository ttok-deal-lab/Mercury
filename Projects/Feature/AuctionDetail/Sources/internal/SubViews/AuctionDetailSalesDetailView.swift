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
        Text("목록 상세내역")
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.bottom, 20)
        
        ForEach(salesItems) { item in
          VStack(alignment: .leading, spacing: 8) {
            let typeText = item.type.displayName
            if !typeText.isEmpty {
              Text(typeText)
                .fonts(.bodySmallBold)
                .foregroundStyle(Asset.Colors.neutral.color)
            }
            Text(item.content)
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
          }
          .padding(.bottom, 16)
        }
      }
      Spacer()
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 20)
  }
}
