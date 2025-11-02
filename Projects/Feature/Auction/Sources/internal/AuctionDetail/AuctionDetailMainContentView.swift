//
//  ItemContentView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI
import Combine

import AppFoundation
import UIComponent
import Domain
import Router

struct AuctionDetailMainContentView<MapView: MapViewable>: View {
  @Binding var modelData: AuctionDetailModelData
  let item: AuctionDetail

  var body: some View {
    VStack(spacing: .zero) {
      AuctionDetailCustomToolbarView(item: item)
      
      ScrollView(.vertical) {
      
        MapView()
          .frame(maxWidth: .infinity)
          .frame(height: 120)
          .clipShape(RoundedRectangle(cornerRadius: 12))
          .padding(.horizontal, 20)
        
        AuctionDetailPicturesPagerView(height: 216, item: item)
        
        AuctionDetailAbstractInfoView(item: item)
      }
    }
    .navigationBarBackButtonHidden()
    .toolbarVisibility(.hidden, for: .navigationBar)
    .alert(error: $modelData.error)
  }
    
 
  
}

