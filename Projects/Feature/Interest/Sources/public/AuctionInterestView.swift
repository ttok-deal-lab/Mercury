//
//  ReportView.swift
//  Report
//
//  Created by 송하민 on 4/13/25.
//

import Foundation
import SwiftUI
import Combine

import AppFoundation
import Domain
import UIComponent
import Router

public struct AuctionInterestView: View {
  @State private var modelData: AuctionInterestModelData
  
  public init(interestUsecase: AuctionInterestUsecasable) {
    self.modelData = AuctionInterestModelData(interestUsecase: interestUsecase)
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar("관심", titleFont: .titleLargeBold) {
        
      }
      .padding(.horizontal, 20)
      
      
      ScrollView(.vertical) {
        if !modelData.interestList.isEmpty {
          LazyVStack(spacing: .zero) {
            ForEach(modelData.interestList) { item in
              AuctionInterestItemView(item: item, onZzim: {
                // TODO: - 찜 제거했을 떄의 액션 
                modelData.interestList.remove(at: modelData.interestList.firstIndex(of: item)!)
                Task {
                  try await modelData.removeUserInterestAuction(auctionID: item.id)
                }
              })
            }
            
            if !modelData.interestList.isEmpty {
              loadMoreView()
            }
            
            if modelData.isLoadingForPaging {
              ProgressView()
                .frame(width: 50, height: 50)
            }
          }
        } else {
            Asset.Images.dot3Circle.image
              .padding(.top, 145)
              .padding(.bottom, 12)
            
            Text(L10n.interestViewNone)
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
        }
      }
      .refreshable {
        await modelData.loadUserInterestAuctions()
      }
    }
    .loading(modelData.isLoading)
    .onLoad  {
      Task {
        await modelData.loadUserInterestAuctions()
        
      }
    }
  }
  
  @ViewBuilder
  private func loadMoreView() -> some View {
    Color.clear
      .task {
        await modelData.loadMoreInterestSales()
      }
  }
}
