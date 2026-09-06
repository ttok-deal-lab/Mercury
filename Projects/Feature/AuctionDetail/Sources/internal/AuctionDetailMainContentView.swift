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
    } else if modelData.loadError != nil {
      AuctionDetailErrorView(isAuctionUnavailable: modelData.isAuctionUnavailable) {
        Task { await modelData.retryLoadAuctionDetail() }
      }
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
          AuctionDetailAbstractInfoView(
            auctionDetailInfo: auctionDetailItem,
            isZzimed: modelData.isZzimed,
            zzimCount: modelData.zzimCount,
            isLoadingZzim: modelData.isLoadingZzim
          ) {
            Task {
              await modelData.tapOnZzim()
            }
          }
          
          dividerView()
          
          // 경매정보 | 권리분석
          AuctionDetailTabPagerContainerView(auctionDetailInfo: auctionDetailItem)
          
          dividerView()
          
          // 경매 히스토리
          AuctionDetailHistoryView(
            auctionStartDateText: auctionDetailItem.salesOpenDate.toKoreanDateString(),
            distributionDeadlineText: auctionDetailItem.distributionRequiredDeadlineDate.toKoreanDateString(),
            investigationDateText: auctionDetailItem.conditionReport.investigationDate?.toKoreanDateString() ?? "-",
            salesDetails: modelData.sortedSalesDetailByTime()
          )
          
          dividerView()
          
          // 법원정보
          AuctionDetailCourtInfoView<MapView>(
            auctionDetailItem: auctionDetailItem,
            mapCoordinate: modelData.mapCoordinate,
            isLoadingMapCoordinate: modelData.isLoadingMapCoordinate
          )
          
          if !auctionDetailItem.salesItemDetails.isEmpty {
            dividerView()
            
            // 목록 상세내역
            AuctionDetailSalesBuildingDetailView(salesItems: auctionDetailItem.salesItemDetails)
          }
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
