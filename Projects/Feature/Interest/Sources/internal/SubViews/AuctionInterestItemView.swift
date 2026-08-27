//
//  InterestItemView.swift
//  Interest
//
//  Created by 최수훈 on 1/12/26.
//

import SwiftUI

import AppFoundation
import Domain
import UIComponent

struct AuctionInterestItemView: View {
  
  let item: InterestItem
  let onZzim: () -> Void
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: 16) {
        CachedAsyncImage(url: item.salesPictures, content: { image in
          image.resizable()
        }) {
          Asset.Colors.gray150.color
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
          VStack(spacing: .zero) {
            HStack(spacing: .zero) {
              Text(item.isSoldOut ? "매각" : "D\(item.salesLeftDays >= 0 ? "+" : "-")\(abs(item.salesLeftDays))")
                .fonts(.captionLargeMedium)
                .foregroundStyle(Asset.Colors.neutralWhite.color)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(item.isSoldOut ? Asset.Colors.neutralSubtler.color : Asset.Colors.neutral.color)
                .clipShape(RoundedRectangle(cornerRadius: 4))
              Spacer()
            }
            .padding(.top, 6)
            .padding(.leading, 6)
            Spacer()
          }
        }
        
        VStack(alignment: .leading, spacing: 2) {
          Text(item.appraisalPrice.toKoreanCurrency)
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyLargeBold)
          
          Text("\(item.salesAddress)")
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyMicroMedium)
            .multilineTextAlignment(.leading)
          
          Text("\(item.salesBuildingName ?? "")")
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
            .fonts(.bodyMicroRegular)
            .multilineTextAlignment(.leading)
          
          Spacer()
          
          HStack(spacing: 5) {
            if item.verified {
              MercuryGradientLabel(title: L10n.commonCertifiedAuction)
            }
            
            if let salesCategoryName = AuctionSalesCategory.mostSpecific(in: item.salesCategories)?.displayName {
              Text(salesCategoryName)
                .fonts(.captionLargeMedium)
                .foregroundStyle(Asset.Colors.primary.color)
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .background(Asset.Colors.primaryLight.color)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            Text(L10n.commonFailedBidCount(item.failBidCount))
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
                  .foregroundStyle(Asset.Colors.critical.color)
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
