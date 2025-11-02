//
//  AuctionHomeView.swift
//  Auction
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import UIComponent
import AppFoundation
import Domain

public struct AuctionHomeView: View {
  @State private var modelData: AuctionHomeModelData
  @State private var error: MercuryError?
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    auctionListUsecase: AuctionSalesListUsecasable
  ) {
    self.navigationStream = navigationStream
    self.modelData = AuctionHomeModelData(auctionListUsecase: auctionListUsecase)
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
              navigationStream.send(.push(.auction(AuctionRoute(route: .auctionDetail(auctionID: 1))))) // TODO: auction 실제 id 필요
            } label: {
              AuctionSalesItemView(
                auctionSalesItemURL: item.salesPictures.first?.url,
                appraisalPrice: item.appraisalPrice,
                locationBuildingName: item.salesAddress,
                category: item.salesCategories
              )
            }
          }
          
          loadMoreView()
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
    .task(priority: .background) {
      do {
        try await modelData.loadAuctionSalesList()
      } catch {
        self.error = error.toMercuryError()
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


