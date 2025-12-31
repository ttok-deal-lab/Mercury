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
  
  public init(recentSalesUsecase: RecentSalesUsecase) {
    self.modelData = RecentSalesModelData( recentViewListUsecase: recentSalesUsecase)
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
                  // TODO: - 찜 했을 때 액션
                })
              }
            }
          }
        }
      } else {
        Asset.Images.dot3Circle.image
          .padding(.top, 145)
          .padding(.bottom, 12)
        
        Text("최근 본 매물이 없어요.")
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
      Spacer()
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

