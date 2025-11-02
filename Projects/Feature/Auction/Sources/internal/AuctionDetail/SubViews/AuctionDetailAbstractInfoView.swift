//
//  AuctionDetailAbstractInfoView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import UIComponent
import Domain

fileprivate enum EasyInformation: String, Identifiable {
  var id: Self { self }
  
  /// 최저 매각 가격
  case minimum_sale_price
  /// 감정가
  case estimated_value
  
}

struct AuctionDetailAbstractInfoView: View {
  
  @State private var showEasyInfoType: EasyInformation?
  let item: AuctionDetail
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: 12) {
        VStack(alignment: .leading, spacing: 6) {
          titleView()
          categoryWithCapacityView()
          auctionNumberView()
        }
        Spacer()
        ZzimButtonView(isZzimed: false, item: item)
      }
      .padding(.bottom, 16)
      
      auctionChipView()
        .padding(.bottom, 16)
      
      VStack(spacing: .zero) {
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
        
        VStack(spacing: 12) {
          /// 감정가
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
        .background(Asset.Colors.gray150.color)
        
      }
      .padding(16)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 1)
          .foregroundStyle(Asset.Colors.gray150.color)
      }
      
    }
    .padding(20)
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
  
  /// 물건 이름
  private func titleView() -> some View {
    Text("\(item.salesAddress)")
      .fonts(.titleLargeBold)
      .foregroundStyle(Asset.Colors.neutral.color)
      .multilineTextAlignment(.leading)
  }
  
  /// 카테고리 및 공급(평형)
  private func categoryWithCapacityView() -> some View {
    HStack(spacing: .zero) {
      if let firstSalesCagetory = item.salesCategories.first?.rawValue {
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
      UIPasteboard.general.string = item.salesNumber
    } label: {
      HStack(spacing: 2) {
        Text("매물번호 \(item.salesNumber)")
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        
        Asset.Images.copy.image
          .resizable()
          .frame(width: 18, height: 18)
      }
    }
  }
  
  /// 물건 칩
  private func auctionChipView() -> some View {
    HStack(spacing: 4) {
      HStack(spacing: 4) {
        Asset.Images.certified.image
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.white)
          .frame(width: 16, height: 16)
        Text("인증매물")
          .foregroundStyle(Asset.Colors.neutralWhite.color)
          .fonts(.bodyMicroMedium)
      }
      .frame(height: 24)
      .padding(.horizontal, 6)
      .background {
        LinearGradient(colors: [Asset.Colors.commonGradientStart.color, Asset.Colors.commonGradientEnd.color], startPoint: .topLeading, endPoint: .bottomTrailing)
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("유찰 2회")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.neutralWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("매각 D-2")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.critical.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.criticalWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("매각 D-4")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.neutralWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Spacer()
    }
  }
  
}
