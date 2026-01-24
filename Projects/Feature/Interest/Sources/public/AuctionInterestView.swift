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
  @State private var modelData: InterestModelData
  
  public init() {
    self.modelData = InterestModelData(interestUsecase: AuctionInterestUsecase())
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar("관심", titleFont: .titleLargeBold) {
        
      }
      .padding(.horizontal, 20)
      
      if !modelData.interestList.isEmpty {
        ScrollView(.vertical) {
          LazyVStack(spacing: .zero) {
            ForEach(modelData.interestList) { item in
              AuctionInterestItemView(item: item, onZzim: {
                  // 찜 제거했을 떄의 액션
                  Task {
                    try await modelData.removeUserInterestAuction(auctionID: item.id)
                  }
                }
              )
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
      
      Spacer()
    }
  }
}
