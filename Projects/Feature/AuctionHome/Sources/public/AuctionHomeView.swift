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

struct AuctionHomeView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: AuctionHomeModelData
  @State private var error: MercuryError?
  @State private var isShowFilterArea: Bool = false
  
  init(
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    localStorageUsecase: LocalStorageUsecasable
  ) {
    self.modelData = AuctionHomeModelData(
      localStorageUsecase: localStorageUsecase,
      auctionListUsecase: auctionListUsecase,
      auctionSearchFilterUsecase: auctionSearchFilterUsecase
    )
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      AuctionHomeNavigationView(
        onSelectArea: { areaName in
          isShowFilterArea = true
        },
        onTapSearch: {
          print("search")
        },
        onTapNotification: {
          print("notification")
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
              // UserDefault 에 id 값 추가
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
        do {
          try await modelData.loadAuctionSalesList()
        } catch {
          self.error = error.toMercuryError()
        }
      }
    }
    .alert(error: $error)
    .loading(modelData.isLoading)
    .onLoad {
      Task {
        do {
          try await modelData.loadAuctionSalesList()
        } catch {
          self.error = error.toMercuryError()
        }
      }
    }
    .sheet(isPresented: $isShowFilterArea, content: {
      AuctionFilterLocationView(modelData: $modelData)
    })
  }
  
  private func shouldTriggerLoadMore(at index: Int) -> Bool {
    print(index)
    let itemCount = modelData.auctionSalesItems.count
    guard itemCount >= 20 else { return false }
    
    let thresholdIndex = itemCount - 3
    return index == thresholdIndex
  }
  
  @ViewBuilder
  private func loadMoreView() -> some View {
    Color.clear
      .task {
        do {
          try await modelData.loadMoreAuctionSales()
        } catch {
          self.error = error.toMercuryError()
        }
      }
  }
}

