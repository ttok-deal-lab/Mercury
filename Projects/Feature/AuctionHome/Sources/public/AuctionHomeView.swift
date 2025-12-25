//
//  AuctionHomeView.swift
//  Auction
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine
import SwiftData

import Router
import UIComponent
import AppFoundation
import Domain

public struct AuctionHomeView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: AuctionHomeModelData
  @State private var isShowFilterArea: Bool = false
  
  public init(
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  ) {
    self.modelData = AuctionHomeModelData(
      auctionListUsecase: auctionListUsecase,
      auctionSearchFilterUsecase: auctionSearchFilterUsecase,
    )
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      AuctionHomeNavigationView(
        applyingSearchFilter: $modelData.currentAuctionFilter,
        onSelectArea: {
          isShowFilterArea = true
        },
        onTapSearch: {
          print("search")
        }
      )
      
      AuctionFilterView(modelData: $modelData)
      
      AuctionSortView(modelData: $modelData)
      
      ScrollView(.vertical) {
        LazyVStack(spacing: .zero) {
          InformCertificationView()
          
          ForEach(modelData.auctionSalesItems) { item in
            Button {
              coordinator.push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: item.id))))
            } label: {
              AuctionSalesItemView(item: item, onZzim: {
                // 찜 했을때의 액션
              })
            }
          }
          
          if !modelData.auctionSalesItems.isEmpty {
            loadMoreView()
          }
          
          if modelData.isLoadingForPaging {
            ProgressView()
              .frame(width: 50, height: 50)
          }
        }
        Spacer()
      }
      .refreshable {
        await modelData.loadAuctionSalesList()
      }
    }
    .alert(error: $modelData.error)
    .loading(modelData.isLoading)
    .onLoad {
      Task {
        await modelData.loadAuctionSalesList()
      }
    }
    .sheet(isPresented: $isShowFilterArea, content: {
      AuctionFilterLocationView(modelData: $modelData) {
        Task {
          await modelData.loadAuctionSalesList()
          isShowFilterArea = false
        }
        
      }
    })
  }
  
  private func shouldTriggerLoadMore(at index: Int) -> Bool {
    let itemCount = modelData.auctionSalesItems.count
    guard itemCount >= 20 else { return false }
    
    let thresholdIndex = itemCount - 3
    return index == thresholdIndex
  }
  
  @ViewBuilder
  private func loadMoreView() -> some View {
    Color.clear
      .task {
        await modelData.loadMoreAuctionSales()
      }
  }
}

