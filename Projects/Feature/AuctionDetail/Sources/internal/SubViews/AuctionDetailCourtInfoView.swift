//
//  AuctionDetailCourtInfoView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI
import CoreLocation

import AppFoundation
import UIComponent
import Domain
import Router

struct AuctionDetailCourtInfoView<MapView: MapViewable>: View {
  @State private var isShowFullMap = false
  let auctionDetailItem: AuctionDetail
  
  let mapCoordinate: CLLocationCoordinate2D?
  let isLoadingMapCoordinate: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      
      Text("매각 정보")
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
          Text("매각장소")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text(auctionDetailItem.salesLocation)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
            .multilineTextAlignment(.trailing)
        }
        
        HStack {
          Text("매각기일")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text(auctionDetailItem.salesDateTime.toKoreanDateString(format: .full))
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
            .multilineTextAlignment(.trailing)
        }
        
        if !auctionDetailItem.salesNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
          HStack {
            Text("매각비고")
              .fonts(.bodyMediumMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
            Spacer()
            Text(auctionDetailItem.salesNote)
              .fonts(.bodyMediumMedium)
              .foregroundStyle(Asset.Colors.neutral.color)
              .multilineTextAlignment(.trailing)
          }
        }
      }
      .padding(.bottom, 20)

      Text("물건 위치")
        .fonts(.bodyMediumMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.bottom, 12)

      mapPreviewView
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
    .fullScreenCover(isPresented: $isShowFullMap, content: {
      if let mapCoordinate {
        MapView(targetLongitude: mapCoordinate.longitude, targetLatitude: mapCoordinate.latitude)
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
      }
    })
  }
}

private extension AuctionDetailCourtInfoView {
  @ViewBuilder
  var mapPreviewView: some View {
    if let mapCoordinate {
      Button {
        isShowFullMap = true
      } label: {
        MapView(targetLongitude: mapCoordinate.longitude, targetLatitude: mapCoordinate.latitude)
          .frame(maxWidth: .infinity)
          .frame(height: 120)
          .clipShape(RoundedRectangle(cornerRadius: 12))
      }
    } else {
      RoundedRectangle(cornerRadius: 12)
        .fill(Asset.Colors.neutralWeak.color)
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .overlay {
          VStack(spacing: 8) {
            if isLoadingMapCoordinate {
              ProgressView()
            }

            Text(isLoadingMapCoordinate ? "위치 정보를 불러오는 중이에요" : "표시할 위치 정보를 찾지 못했어요")
              .fonts(.bodyMediumMedium)
              .foregroundStyle(Asset.Colors.neutralSubtle.color)
          }
          .padding(.horizontal, 20)
        }
    }
  }
}
