//
//  RecentSalesView.swift
//  MyPage
//
//  Created by 최수훈 on 11/16/25.
//

import Combine
import SwiftData
import SwiftUI

import Domain
import UIComponent
import Router

public struct RecentSalesView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: RecentSalesModelData
  
  public init(recentSalesUsecase: RecentSalesUsecase,
              auctionInterestUsecase: AuctionInterestUsecase) {
    self.modelData = RecentSalesModelData(
      recentViewListUsecase: recentSalesUsecase,
      auctionInterestUsecase: auctionInterestUsecase
    )
  }
  
  public var body: some View {
    VStack {
      MercuryNavigationBar(L10n.settingRecentViewSales) {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      if !modelData.recentViewList.isEmpty {
        ScrollView(.vertical) {
          LazyVStack(spacing: .zero) {
            ForEach(modelData.recentViewList, id: \.id) { item in
              Button {
                coordinator.push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: item.id))))
              } label: {
                RecentSalesItemView(item: item, onZzim: {
                  Task {
                    try await modelData.tapOnZzim(auctionID: item.id)
                  }
                })
              }
            }
          }
        }
      } else {
        Asset.Images.dot3Circle.image
          .padding(.top, 145)
          .padding(.bottom, 12)
        
        Text(L10n.settingRecentViewNone)
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
    }
    .loading(modelData.isLoading)
    .onLoad {
      Task {
        try await modelData.loadRecentViewList()
      }
    }
    .navigationBarBackButtonHidden()
  }
}

