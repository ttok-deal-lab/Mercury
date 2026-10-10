//
//  PlaceSearchView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import AppFoundation
import Domain
import UIComponent
import Router

/// 주소지 검색. 검색 전에는 검색 가이드, 검색 후에는 결과 목록을 보여준다.
struct PlaceSearchView<LocationPicker: LocationPickerMapViewable>: View {
  @Environment(\.dismiss) private var dismiss
  @State private var modelData: PlaceSearchModelData
  @State private var isMapPresented: Bool = false
  @FocusState private var isFieldFocused: Bool
  
  private let addressSearchUsecase: AddressSearchUsecasable
  private let serviceRegionName: String?
  private let initialPlace: AddressInfo?
  private let onSelect: (AddressInfo) -> Void
  
  init(
    addressSearchUsecase: AddressSearchUsecasable,
    serviceRegionName: String?,
    initialPlace: AddressInfo?,
    onSelect: @escaping (AddressInfo) -> Void
  ) {
    self.modelData = PlaceSearchModelData(addressSearchUsecase: addressSearchUsecase)
    self.addressSearchUsecase = addressSearchUsecase
    self.serviceRegionName = serviceRegionName
    self.initialPlace = initialPlace
    self.onSelect = onSelect
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      PlaceNavigationBarView(title: L10n.reportPlaceSearchTitle) {
        dismiss()
      }
      
      VStack(alignment: .trailing, spacing: 12) {
        searchField()
        
        Button {
          isMapPresented = true
        } label: {
          HStack(spacing: 4) {
            Asset.Images.placeLocation.image
              .resizable()
              .frame(width: 14, height: 14)
            Text(L10n.reportPlaceSearchMap)
              .fonts(.bodyMicroRegular)
              .foregroundStyle(Asset.Colors.neutral.color)
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      
      Rectangle()
        .fill(Asset.Colors.neutralWeak.color)
        .frame(height: 8)
      
      if !modelData.hasSearched {
        ScrollView(.vertical) {
          PlaceSearchGuideView()
        }
        .background(Asset.Colors.neutralLight.color)
      } else if modelData.results.isEmpty {
        Text(L10n.reportPlaceSearchEmpty)
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
          .padding(.top, 80)
        Spacer()
      } else {
        ScrollView(.vertical) {
          LazyVStack(spacing: .zero) {
            ForEach(modelData.results) { address in
              Button {
                onSelect(address)
              } label: {
                PlaceSearchResultRowView(
                  address: address,
                  isServiceAvailable: address.isInServiceRegion(serviceRegionName)
                )
              }
              Rectangle()
                .fill(Asset.Colors.neutralWeak.color)
                .frame(height: 1)
            }
          }
        }
        .scrollDismissesKeyboard(.interactively)
      }
    }
    .background(Asset.Colors.neutralWhite.color)
    .loading(modelData.isLoading)
    .alert(error: $modelData.error)
    .navigationBarBackButtonHidden()
    .onAppear { isFieldFocused = !modelData.hasSearched }
    .navigationDestination(isPresented: $isMapPresented) {
      PlaceMapSelectView<LocationPicker>(
        addressSearchUsecase: addressSearchUsecase,
        serviceRegionName: serviceRegionName,
        initialPlace: initialPlace,
        onSelect: onSelect
      )
    }
  }
  
  private func searchField() -> some View {
    HStack(spacing: 8) {
      ZStack(alignment: .leading) {
        if modelData.query.isEmpty {
          Text(L10n.reportPlaceSearchPlaceholder)
            .fonts(.bodySmallMedium)
            .foregroundStyle(Asset.Colors.neutralSubtle.color)
        }
        TextField("", text: $modelData.query)
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
          .focused($isFieldFocused)
          .submitLabel(.search)
          .autocorrectionDisabled()
          .onSubmit {
            Task { await modelData.search() }
          }
      }
      
      if !modelData.query.isEmpty {
        Button {
          modelData.clear()
          isFieldFocused = true
        } label: {
          Asset.Images.close.image
            .renderingMode(.template)
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
        }
      }
    }
    .padding(.horizontal, 12)
    .frame(height: 44)
    .overlay {
      RoundedRectangle(cornerRadius: 8)
        .stroke(isFieldFocused ? Asset.Colors.primary.color : Asset.Colors.gray100BorderDefault.color, lineWidth: 1)
    }
  }
}
