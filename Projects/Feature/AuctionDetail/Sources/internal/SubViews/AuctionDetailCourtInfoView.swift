//
//  AuctionDetailCourtInfoView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

import UIComponent
import Domain
import Router

struct AuctionDetailCourtInfoView<MapView: MapViewable>: View {
  @State private var isShowFullMap = false
  let auctionDetailItem: AuctionDetail
  
  let courtLongitude: CGFloat
  let courtLatitude: CGFloat
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      
      Text("법원정보")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.bottom, 20)
      
      VStack(spacing: 24) {
        HStack {
          Text("관할법원")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text(auctionDetailItem.court.name)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        
        HStack {
          Text("담당")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text(auctionDetailItem.court.team)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        
        HStack {
          Text("매각기일")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text(auctionDetailItem.salesDateTime.toKoreanDateString())
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        
        HStack {
          Text("입찰시간")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text("10:00 - 11:10")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        
        HStack {
          Text("개찰시간")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text("11:30")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
      }
      .padding(.bottom, 20)
      
      Button {
        isShowFullMap = true
      } label: {
        MapView(targetLongitude: courtLongitude, targetLatitude: courtLatitude)
          .frame(maxWidth: .infinity)
          .frame(height: 120)
          .clipShape(RoundedRectangle(cornerRadius: 12))
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
    .fullScreenCover(isPresented: $isShowFullMap, content: {
      MapView(targetLongitude: courtLongitude, targetLatitude: courtLatitude)
        .ignoresSafeArea()
        .overlay(alignment: .topTrailing) {
          Button {
            isShowFullMap = false
          } label: {
            Asset.Images.close.image
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundStyle(.black)
              .padding(4)
              .background(.white)
              .clipShape(Circle())
              .shadows(.shadowHighest)
          }
          .padding(.trailing, 15)
        }
    })
  }
}
