//
//  AbstractTopCardView.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

fileprivate enum AuctionDetailEasyInformation: String, Identifiable {
  var id: Self { self }
  
  /// 최저 매각 가격
  case minimum_sale_price
  /// 감정가
  case estimated_value
}

struct AuctionDetailAbstractTopCardView: View {
  @State private var showEasyInfoType: AuctionDetailEasyInformation?
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    VStack(spacing: .zero) {
      minimumSalePriceSection()
      
      VStack(spacing: 12) {
        estimatedValueRow()
        recentDealRow()
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
    .sheet(item: $showEasyInfoType) { type in
      switch type {
      case .minimum_sale_price:
        Text("최저매각가격이란? 시트")
          .dynamicSheet()
      case .estimated_value:
        Text("감정가 시트")
          .dynamicSheet()
      }
    }
  }
  
  private func minimumSalePriceSection() -> some View {
    VStack(spacing: .zero) {
      // 최저 매각 가격
      HStack(spacing: .zero) {
        Button {
          showEasyInfoType = .minimum_sale_price
        } label: {
          HStack(spacing: .zero) {
            HStack(spacing: 3) {
              Text("최저매각가격")
                .fonts(.bodySmallMedium)
                .foregroundStyle(Asset.Colors.neutralSubtler.color)
              Asset.Images.infoLine.image
                .resizable()
                .frame(width: 16, height: 16)
            }
            Spacer()
          }
        }
        Spacer()
        Text("1억 8,320만원")
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
      }
      Spacer()
      HStack(spacing: 2) {
        Spacer()
        Text("감정가대비")
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Text("-4,800만원 (10.84%)")
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.primary.color)
      }
    }
    .padding(16)
  }
  
  
  /// 감정가 행
  private func estimatedValueRow() -> some View {
    HStack(spacing: .zero) {
      Button {
        showEasyInfoType = .estimated_value
      } label: {
        HStack(spacing: .zero) {
          HStack(spacing: 3) {
            Text("감정가")
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
            Asset.Images.infoLine.image
              .resizable()
              .frame(width: 16, height: 16)
            Spacer()
          }
        }
      }
      Spacer()
      Text("2억 3,000만원")
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
    }
  }

  /// 최근 실거래가 행
  private func recentDealRow() -> some View {
    HStack(spacing: .zero) {
      HStack(spacing: 4) {
        Text("최근실거래가")
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Text("(25.03.16)")
          .fonts(.bodyMicroRegular)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
      Spacer()
      Text("5억 5,421만원")
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
    }
  }

  /// 매각기일 행
  private func auctionDateRow() -> some View {
    HStack(spacing: .zero) {
      Text("매각기일")
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
      Spacer()
      Text("2025.04.08 10:00")
        .fonts(.bodyLargeBold)
        .foregroundStyle(Asset.Colors.neutral.color)
    }
  }
}
