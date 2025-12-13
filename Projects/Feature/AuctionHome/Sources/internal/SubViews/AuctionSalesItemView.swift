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
  let item: AuctionSalesItem
  let onZzim: () -> Void

  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: 16) {
        CachedAsyncImage(url: item.salesPictures.first?.url, content: { image in
          image.resizable()
        }) {
          Asset.Colors.gray150.color
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
          VStack(spacing: .zero) {
            HStack(spacing: .zero) {
              Text("D\(item.salesLeftDays >= 0 ? "+" : "-")\(abs(item.salesLeftDays))")
                .fonts(.captionLargeMedium)
                .foregroundStyle(Asset.Colors.neutralWhite.color)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(Asset.Colors.neutral.color)
                .clipShape(RoundedRectangle(cornerRadius: 4))
              Spacer()
            }
            .padding(.top, 6)
            .padding(.leading, 6)
            Spacer()
          }
        }
        
        VStack(alignment: .leading, spacing: 2) {
          Text(L10n.commonWon(item.appraisalPrice))
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyLargeBold)
          
          Text("\(item.salesAddress)")
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyMicroMedium)
            .multilineTextAlignment(.leading)
          
          Spacer()
          
          HStack(spacing: 5) {
            if !item.salesCategories.isEmpty,
               let firstSalesCategory = item.salesCategories.first?.rawValue {
              Text(firstSalesCategory)
                .fonts(.captionLargeMedium)
                .foregroundStyle(Asset.Colors.primary.color)
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .background(Asset.Colors.primaryLight.color)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            Text("유찰 \(item.failBidCount)회")
              .fonts(.captionLargeMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
              .padding(.vertical, 3)
              .padding(.horizontal, 6)
              .background(Asset.Colors.neutralWeak.color)
              .clipShape(RoundedRectangle(cornerRadius: 4))
            
            Spacer()
            
            Button {
              onZzim()
            } label: {
              HStack(spacing: 4) {
                Asset.Images.heart.image
                  .renderingMode(.template)
                  .resizable()
                  .foregroundStyle(Asset.Colors.neutralMuted.color)
                  .frame(width: 18, height: 18)
                
                Text("\(item.zzimCount)")
                  .fonts(.bodyMicroMedium)
                  .foregroundStyle(Asset.Colors.neutralSubtle.color)
              }
            }
          }
        }
        .padding(.vertical, 4)
        
        Spacer()
      }
      .padding(.leading, 20)
      .padding(.vertical, 16)
    }
  }
}
