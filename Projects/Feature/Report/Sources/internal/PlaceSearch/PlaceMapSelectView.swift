//
//  PlaceMapSelectView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import AppFoundation
import Domain
import UIComponent
import Router

/// 지도에서 위치 선택. 지도를 움직이면 가운데 핀 위치의 주소를 아래 카드에 보여준다.
struct PlaceMapSelectView<LocationPicker: LocationPickerMapViewable>: View {
  @Environment(\.dismiss) private var dismiss
  @State private var modelData: PlaceMapSelectModelData
  @State private var locationProvider = CurrentLocationProvider()
  
  private let serviceRegionName: String?
  private let onSelect: (AddressInfo) -> Void
  
  init(
    addressSearchUsecase: AddressSearchUsecasable,
    serviceRegionName: String?,
    initialPlace: AddressInfo?,
    onSelect: @escaping (AddressInfo) -> Void
  ) {
    self.modelData = PlaceMapSelectModelData(addressSearchUsecase: addressSearchUsecase, initialPlace: initialPlace)
    self.serviceRegionName = serviceRegionName
    self.onSelect = onSelect
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      PlaceNavigationBarView(title: L10n.reportPlaceMapTitle) {
        dismiss()
      }
      
      ZStack {
        LocationPicker(
          initialLatitude: modelData.initialLatitude,
          initialLongitude: modelData.initialLongitude,
          moveRequest: $modelData.moveRequest,
          onCenterChanged: { latitude, longitude in
            modelData.centerChanged(latitude: latitude, longitude: longitude)
          },
          onMoveStarted: {
            modelData.moveStarted()
          }
        )
        
        centerPin()
        
        VStack {
          Spacer()
          HStack {
            Spacer()
            Button {
              Task {
                guard let coordinate = await locationProvider.requestCurrentLocation() else { return }
                modelData.moveTo(latitude: coordinate.latitude, longitude: coordinate.longitude)
              }
            } label: {
              Asset.Images.placeLocation.image
                .frame(width: 44, height: 44)
                .background(Asset.Colors.neutralWhite.color)
                .clipShape(Circle())
                .shadows(.shadowMedium)
            }
          }
          .padding(16)
        }
      }
      
      addressCard()
    }
    .background(Asset.Colors.neutralWhite.color)
    .alert(error: $modelData.error)
    .navigationBarBackButtonHidden()
  }
  
  /// 화면 가운데 고정 핀 + 안내 말풍선. 핀 끝이 지도 중앙 좌표를 가리킨다.
  private func centerPin() -> some View {
    VStack(spacing: 12) {
      // 원본 색(파란 핀 + 흰 원) 그대로 쓴다
      Asset.Images.place.image
        .resizable()
        .scaledToFit()
        .frame(width: 36, height: 36)
        .offset(y: modelData.isMoving ? -8 : 0)
        .animation(.easeOut(duration: 0.15), value: modelData.isMoving)
      
      Text(L10n.reportPlaceMapHint)
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralWhite.color)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Asset.Colors.neutral.color.opacity(0.7))
        .clipShape(Capsule())
    }
    // 핀 아래 끝이 정확히 중앙에 오도록 핀 높이만큼 올리고, 말풍선 높이는 아래로 보낸다.
    .offset(y: 30)
    .allowsHitTesting(false)
  }
  
  private func addressCard() -> some View {
    VStack(alignment: .leading, spacing: 8) {
      if let address = modelData.centerAddress {
        if address.isInServiceRegion(serviceRegionName) {
          PlaceServiceBadgeView()
        }
        Text(address.displayAddress)
          .fonts(.titleMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
          .lineLimit(2)
        if address.roadAddress != nil, let jibun = address.jibunAddress {
          HStack(spacing: 6) {
            Text(L10n.reportPlaceJibun)
              .fonts(.captionLargeMedium)
              .foregroundStyle(Asset.Colors.neutralSubtle.color)
              .padding(.horizontal, 4)
              .padding(.vertical, 2)
              .background(Asset.Colors.neutralWeak.color)
              .clipShape(RoundedRectangle(cornerRadius: 4))
            Text(jibun)
              .fonts(.bodyMicroRegular)
              .foregroundStyle(Asset.Colors.neutralSubtle.color)
          }
        }
      } else {
        Text(modelData.isResolving ? " " : L10n.reportPlaceMapNoAddress)
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
      
      MercuryButton(L10n.reportPlaceMapConfirm) {
        guard let address = modelData.centerAddress else { return }
        onSelect(address)
      }
      .disabled(modelData.centerAddress == nil || modelData.isMoving)
      .opacity(modelData.centerAddress == nil || modelData.isMoving ? 0.5 : 1)
      .padding(.top, 12)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(20)
    .background(Asset.Colors.neutralWhite.color)
    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, topTrailingRadius: 16))
    .shadows(.shadowHigh)
  }
}
