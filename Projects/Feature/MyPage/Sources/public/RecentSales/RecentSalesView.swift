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

struct RecentSalesView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  private let modelData: RecentSalesModelData
  private var recentSales: [AuctionSalesItem]
  
  
  var body: some View {
    VStack {
      MercuryNavigationBar(L10n.settingRecentViewSales) {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      ScrollView(.vertical) {
        LazyVStack(spacing: .zero) {
          ForEach(recentSales, id: \.id) { item in
            Button {
              coordinator.push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: item.id))))
            } label: {
              
            }
          }
        }
      }
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
}

