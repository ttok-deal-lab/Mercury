//
//  ItemContentView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI
import Combine

import AppFoundation
import UIComponent
import Domain
import Router

struct AuctionDetailMainContentView<MapView: MapViewable>: View {
  @Binding var modelData: AuctionDetailModelData
  
  var body: some View {
    if let auctionDetailItem = modelData.auctionDetailItem {
      mainContentView(auctionDetailItem: auctionDetailItem)
    } else {
      ProgressView()
    }
  }
  
  // MARK: - Main Content View
  
  @ViewBuilder
  func mainContentView(auctionDetailItem: AuctionDetail) -> some View {
    VStack(spacing: .zero) {
      AuctionDetailCustomToolbarView(auctionDetailInfo: auctionDetailItem)
      
      ScrollView(.vertical) {
        VStack(spacing: .zero) {
          // 사진 Pager
          AuctionDetailPicturesPagerView(height: 216, auctionDetailInfo: auctionDetailItem)
          // 요약정보
          AuctionDetailAbstractInfoView(auctionDetailInfo: auctionDetailItem)
          
          dividerView()
          
          // 경매정보 | 권리분석 | 건물정보
          AuctionDetailTabPagerContainerView(auctionDetailInfo: auctionDetailItem)
          
          dividerView()
          
          // 경매 히스토리
          AuctionDetailHistoryView(
            auctionStartDateText: auctionDetailItem.salesOpenDate.toKoreanDateString(),
            distributionDeadlineText: auctionDetailItem.distributionRequiredDeadlineDate.toKoreanDateString(),
            appraisalDateText: auctionDetailItem.conditionReport.investigationDate.toKoreanDateString(),
            salesDetails: modelData.sortedSalesDetailByTime()
          )
          
          dividerView()
          
          // 등기부 현황
          AuctionDetailRegisterStatusView()
          
          dividerView()
          
          // 법원정보
          AuctionDetailCourtInfoView<MapView>(
            auctionDetailItem: auctionDetailItem,
            courtLongitude: 127.108678, // 아직 위경도 안내려줌
            courtLatitude: 37.402001
          )
          
          dividerView()
          
          // 건물 상세내역
          AuctionDetailSalesBuildingDetailView(salesItems: auctionDetailItem.salesItemDetails)
        }
      }
    }
    .navigationBarBackButtonHidden()
    .toolbarVisibility(.hidden, for: .navigationBar)
    .alert(error: $modelData.error)
  }

  private func dividerView(height: CGFloat = 10) -> some View {
    Rectangle()
      .frame(height: height)
      .foregroundStyle(Asset.Colors.neutralWeak.color)
  }
}

