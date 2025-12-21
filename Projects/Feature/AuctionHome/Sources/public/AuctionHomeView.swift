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
  @State private var modelData: AuctionHomeModelData
  @State private var error: MercuryError?
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    navigationStream: PassthroughSubject<
    NavigationEvent<FeatureRoute>,Never>,
    auctionListUsecase: AuctionSalesListUsecasable,
    modelContext: ModelContext
  ) {
    self.navigationStream = navigationStream
    self.modelData = AuctionHomeModelData(
      auctionListUsecase: auctionListUsecase,
      modelContext: modelContext
    )
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      AuctionHomeNavigationView(
        onSelectArea: { areaName in
          print(areaName)
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
              navigationStream.send(.push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: item.id)))))
              modelData.saveRecentItem(item)
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

