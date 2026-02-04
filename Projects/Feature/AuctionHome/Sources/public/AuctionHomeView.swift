//
//  AuctionHomeView.swift
//  Auction
//
//  Created by 송하민 on 4/13/25.
//

import Combine
import SwiftData
import SwiftUI

import AppFoundation
import Domain
import UIComponent
import Router

public struct AuctionHomeView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: AuctionHomeModelData
  @State private var isShowFilterArea: Bool = false
  private var isZzim: Bool = false
  
  public init(
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    auctionInterestUsecase: AuctionInterestUsecasable,
    localStorageUsecase: LocalStorageUsecasable
  ) {
    self.modelData = AuctionHomeModelData(
      localStorageUsecase: localStorageUsecase,
      auctionListUsecase: auctionListUsecase,
      auctionSearchFilterUsecase: auctionSearchFilterUsecase,
      auctionInterestUsecase: auctionInterestUsecase
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
          coordinator.push(.search(SearchRoute(route: .searchHome)))
        }
      )
      
      AuctionFilterView()
      
      AuctionSortView()
      
      ScrollView(.vertical) {
        LazyVStack(spacing: .zero) {
          InformCertificationView()
          
          ForEach(modelData.auctionSalesItems) { item in
            Button {
              coordinator.push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: item.id))))
              Task {
                await modelData.saveRecentSales(id: item.id)
              }
            } label: {
              AuctionSalesItemView(item: item, onZzim: {
                // TODO: - 찜 버튼 토글 추가
                Task {
                  try await modelData.addInterest(auctionID: item.id)
                }
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
    .environment(modelData)
    .alert(error: $modelData.error)
    .loading(modelData.isLoading)
    .onLoad {
      Task {
        await modelData.loadAuctionSalesList(withFilter: false)
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

