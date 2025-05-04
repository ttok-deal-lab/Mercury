//
//  AuctionItemView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct AuctionItemView: View {
  
  var appraisalPrice: Int
  var locationBuildingName: String
  var locationAddressName: String
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: 16) {
        RoundedRectangle(cornerRadius: 8) // 사진 임시
          .foregroundStyle(.gray.opacity(0.7))
          .frame(width: 100, height: 100)
        
        VStack(alignment: .leading, spacing: 2) {
          Text("\(appraisalPrice)원")
            .foregroundStyle(Asset.Colors.gray700TextDefault.color)
            .fonts(.bodyLargeBold)
          Text("\(locationBuildingName)")
            .foregroundStyle(Asset.Colors.gray700TextDefault.color)
            .fonts(.bodyMicroMedium)
          Text("\(locationAddressName)")
            .foregroundStyle(Asset.Colors.gray400TextSubText.color)
            .fonts(.bodyMicroRegular)
        }
        
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      
    }
  }
}
