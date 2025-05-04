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
    auctionListUsecase: AuctionListUsecasable
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
      
      AuctionFilterView()
      
      AuctionSortView(modelData: $modelData)
      
      InformCertificationView()
      
      Text("리스트")
      
      Spacer()
  
    }
    .alert(error: $error)
    .loading(modelData.isLoading)
    .task(priority: .background) {
      do {
        try await modelData.loadAuctionList()
      } catch {
        self.error = error as? MercuryError
      }
    }
    
  }
}
