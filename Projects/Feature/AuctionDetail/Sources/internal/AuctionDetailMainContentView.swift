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
  @State private var isShowFullMap = false // 지도 상호작용 상태
  
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
        AuctionDetailPicturesPagerView(height: 216, auctionDetailInfo: auctionDetailItem)
        
        AuctionDetailAbstractInfoView(auctionDetailInfo: auctionDetailItem)
        
        AuctionDetailTabPagerContainer(auctionDetailInfo: auctionDetailItem)
        
        Button {
          isShowFullMap = true
        } label: {
          MapView(targetLongitude: 127.108678, targetLatitude: 37.402001)
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
        }
      }
    }
    .fullScreenCover(isPresented: $isShowFullMap, content: {
      MapView(targetLongitude: 127.108678, targetLatitude: 37.402001)
        .ignoresSafeArea()
        .overlay(alignment: .topTrailing) {
          Button {
            isShowFullMap = false
          } label: {
            Asset.Images.close.image
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundStyle(.black)
              .padding(4)
              .background(.white)
              .clipShape(Circle())
              .shadows(.shadowHighest)
          }
          .padding(.trailing, 15)
        }
    })
    .navigationBarBackButtonHidden()
    .toolbarVisibility(.hidden, for: .navigationBar)
    .alert(error: $modelData.error)
  }

}

