//
//  AbstractTitleInfoView.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailAbstractTitleInfoView: View {
  let auctionDetailInfo: AuctionDetail
  let isZzimed: Bool
  let zzimCount: Int
  let isLoadingZzim: Bool
  let onTapZzim: () -> Void
  
  private var categoryText: String? {
    let categories = auctionDetailInfo.salesCategories
      .map(\.displayName)
      .filter { !$0.isEmpty }
    guard !categories.isEmpty else { return nil }
    return categories.joined(separator: " · ")
  }
  
  var body: some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 6) {
        titleView()
        categoryView()
        auctionNumberView()
      }
      Spacer()
      ZzimCountView(
        isZzimed: isZzimed,
        zzimCount: zzimCount,
        isLoading: isLoadingZzim,
        onTap: onTapZzim
      )
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
  
  /// 카테고리 정보
  @ViewBuilder
  private func categoryView() -> some View {
    if let categoryText {
      Text(categoryText)
        .fonts(.bodyMiniMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
    }
  }
  
  /// 사건 번호
  private func auctionNumberView() -> some View {
    Button {
      UIPasteboard.general.string = auctionDetailInfo.salesNumber
    } label: {
      HStack(spacing: 2) {
        Text(L10n.auctionDetailSalesNumber(auctionDetailInfo.salesNumber))
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        
        Asset.Images.copy.image
          .resizable()
          .frame(width: 18, height: 18)
      }
    }
  }
}

fileprivate struct ZzimCountView: View {
  let isZzimed: Bool
  let zzimCount: Int
  let isLoading: Bool
  let onTap: () -> Void
  
  var body: some View {
    VStack(spacing: 4) {
      Button(action: onTap) {
        if isLoading {
          ProgressView()
            .controlSize(.small)
            .frame(width: 28, height: 28)
        } else {
          Asset.Images.heart.image
            .renderingMode(.template)
            .resizable()
            .foregroundStyle(isZzimed ? Asset.Colors.critical.color : Asset.Colors.gray150.color)
            .frame(width: 28, height: 28)
        }
      }
      .disabled(isLoading)
      Text("\(zzimCount)")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtle.color)
      
      Spacer()
    }
  }
}
