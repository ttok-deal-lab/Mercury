//
//  AbstractTopCardView.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

struct AuctionDetailAbstractTopCardView: View {
  let auctionDetailInfo: AuctionDetail
  
  private var priceDifference: Int {
    auctionDetailInfo.lowestSalesPrice - auctionDetailInfo.appraisalPrice
  }
  
  private var priceDifferenceRate: Double {
    guard auctionDetailInfo.appraisalPrice > 0 else { return 0 }
    return (Double(priceDifference) / Double(auctionDetailInfo.appraisalPrice)) * 100
  }
  
  private var priceDifferenceText: String {
    let rateText = String(format: "%.2f", abs(priceDifferenceRate))
    if priceDifference == 0 {
      return "감정가와 동일"
    }
    return "\(priceDifference.toKoreanWon) (\(rateText)%)"
  }
  
  private var priceDifferenceColor: Color {
    priceDifference <= 0 ? Asset.Colors.primary.color : Asset.Colors.critical.color
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      minimumSalePriceSection()
      
      VStack(spacing: 12) {
        estimatedValueRow()
//        salesLocationRow()
//        salesReceptionDateRow()
        auctionDateRow()
      }
      .padding(16)
      .background(Asset.Colors.neutralLight.color)
    }
    .clipShape(RoundedRectangle(cornerRadius: 8))
    .overlay {
      RoundedRectangle(cornerRadius: 8)
        .stroke(lineWidth: 1)
        .foregroundStyle(Asset.Colors.gray150.color)
    }
  }
  
  private func minimumSalePriceSection() -> some View {
    VStack(spacing: .zero) {
      // 최저 매각 가격
      HStack(spacing: .zero) {
        Text("최저매각가격")
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Spacer()
        Text(auctionDetailInfo.lowestSalesPrice.toKoreanCurrency())
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
      }
      Spacer()
      HStack(spacing: 2) {
        Spacer()
        Text("감정가대비")
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Text(priceDifferenceText)
          .fonts(.bodyMicroMedium)
          .foregroundStyle(priceDifferenceColor)
      }
    }
    .padding(16)
  }
  
  
  /// 감정가 행
  private func estimatedValueRow() -> some View {
    infoRow(title: "감정가", value: auctionDetailInfo.appraisalPrice.toKoreanCurrency())
  }

  /// 매각장소 행
  private func salesLocationRow() -> some View {
    infoRow(title: "매각장소", value: auctionDetailInfo.salesLocation)
  }

  /// 매각기일 행
  private func auctionDateRow() -> some View {
    infoRow(
      title: "매각기일",
      value: auctionDetailInfo.salesDateTime.toKoreanDateString(format: .full),
      valueFont: .bodySmallBold,
      valueColor: Asset.Colors.neutral.color
    )
  }
  
  private func salesReceptionDateRow() -> some View {
    infoRow(title: "접수마감", value: auctionDetailInfo.salesReceptionDate.toKoreanDateString())
  }
  
  private func infoRow(
    title: String,
    value: String,
    valueFont: MercuryFont = .bodySmallMedium,
    valueColor: Color = Asset.Colors.neutralSubtler.color
  ) -> some View {
    HStack(spacing: .zero) {
      Text(title)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
      Spacer()
      Text(value)
        .fonts(valueFont)
        .foregroundStyle(valueColor)
        .multilineTextAlignment(.trailing)
    }
  }
}
