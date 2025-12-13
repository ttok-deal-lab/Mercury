//
//  AbstractTitleInfoView.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

struct AbstractTitleInfoView: View {
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 6) {
        titleView()
        categoryWithCapacityView()
        auctionNumberView()
      }
      Spacer()
      ZzimButtonView(isZzimed: false, item: auctionDetailInfo)
    }
    .padding(.bottom, 16)
  }
  
  /// 물건 이름
  private func titleView() -> some View {
    Text("\(auctionDetailInfo.salesAddress)")
      .fonts(.titleLargeBold)
      .foregroundStyle(Asset.Colors.neutral.color)
      .multilineTextAlignment(.leading)
  }
  
  /// 카테고리 및 공급(평형)
  private func categoryWithCapacityView() -> some View {
    HStack(spacing: .zero) {
      if let firstSalesCagetory = auctionDetailInfo.salesCategories.first?.rawValue {
        Text("\(firstSalesCagetory)")
        Text("ㅣ")
      }
      Text("공급 110.52㎡ (33평) - Mock data")
    }
    .fonts(.bodyMiniMedium)
    .foregroundStyle(Asset.Colors.neutralSubtler.color)
  }
  
  /// 사건 번호
  private func auctionNumberView() -> some View {
    Button {
      UIPasteboard.general.string = auctionDetailInfo.salesNumber
    } label: {
      HStack(spacing: 2) {
        Text("매물번호 \(auctionDetailInfo.salesNumber)")
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        
        Asset.Images.copy.image
          .resizable()
          .frame(width: 18, height: 18)
      }
    }
  }
}
