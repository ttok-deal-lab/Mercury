//
//  CrewRoomCreateView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import AppFoundation
import Domain
import UIComponent
import Router

struct CreateCrewFormView<LocationPicker: LocationPickerMapViewable>: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: CrewRoomCreateModelData
  @State private var isRegionSheetPresented: Bool = false
  @State private var isPlaceSearchPresented: Bool = false
  @State private var isVisitDatePresented: Bool = false
  @State private var isPeriodPickerPresented: Bool = false
  private let addressSearchUsecase: AddressSearchUsecasable
  
  init(
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    addressSearchUsecase: AddressSearchUsecasable
  ) {
    self.modelData = CrewRoomCreateModelData(auctionSearchFilterUsecase: auctionSearchFilterUsecase)
    self.addressSearchUsecase = addressSearchUsecase
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar() {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 28) {
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateTitleLabel) {
            CrewLeaderTextFieldView(text: $modelData.title, placeholder: L10n.reportCrewCreateTitlePlaceholder)
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateIntroLabel) {
            CrewLeaderIntroEditorView(
              text: $modelData.introduction,
              placeholder: L10n.reportLeaderProfileIntroPlaceholder
            )
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateRegionLabel, isRequired: true) {
            CrewRoomChipButtonView(title: modelData.regionText ?? L10n.reportCrewCreateRegionSelect) {
              isRegionSheetPresented = true
            }
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreatePlaceLabel, isRequired: true) {
            VStack(alignment: .leading, spacing: 8) {
              CrewRoomChipButtonView(title: modelData.place?.displayAddress ?? L10n.reportCrewCreatePlaceSelect) {
                isPlaceSearchPresented = true
              }
              
              CrewLeaderTextFieldView(text: $modelData.address, placeholder: L10n.reportCrewCreateAddressPlaceholder)
            }
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateDateLabel, isRequired: true) {
            CrewRoomDateFieldView(text: modelData.visitDateText, placeholder: L10n.reportCrewCreateDatePlaceholder) {
              isVisitDatePresented = true
            }
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreatePeriodLabel, isRequired: true) {
            CrewRoomDateFieldView(text: modelData.recruitPeriodText, placeholder: L10n.reportCrewCreateDatePlaceholder) {
              isPeriodPickerPresented = true
            }
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateMembersLabel, isRequired: true) {
            CrewLeaderTextFieldView(
              text: Binding(get: { modelData.maxMembers }, set: { modelData.updateMaxMembers($0) }),
              placeholder: L10n.reportCrewCreateMembersPlaceholder,
              isNumeric: true,
              showsClearButton: true
            )
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateFeeLabel, isRequired: true) {
            CrewLeaderTextFieldView(
              text: Binding(get: { modelData.feeText }, set: { modelData.updateFee($0) }),
              placeholder: L10n.reportCrewCreateFeePlaceholder,
              isNumeric: true,
              showsClearButton: true
            )
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateAnalysisLabel) {
            CrewRoomAnalysisChipsView(selectedTypes: modelData.selectedAnalysisTypes) { type in
              modelData.toggleAnalysisType(type)
            }
          }
          
          if !modelData.selectedAnalysisTypes.isEmpty {
            CrewLeaderFormSectionView(title: modelData.analysisSectionTitle) {
              CrewLeaderIntroEditorView(
                text: $modelData.analysisContent,
                placeholder: L10n.reportCrewCreateAnalysisPlaceholder
              )
            }
          }
        }
        .padding(.horizontal, 20)
        .padding(.top, 19)
        .padding(.bottom, 24)
      }
      .scrollDismissesKeyboard(.interactively)
      
      MercuryButton(L10n.reportCrewCreateSubmit) {
        Task {
          guard await modelData.submit() else { return }
          coordinator.pop()
        }
      }
      .disabled(!modelData.isSubmittable)
      .opacity(modelData.isSubmittable ? 1 : 0.5)
      .padding(.horizontal, 20)
      .padding(.vertical, 8)
    }
    .background(Asset.Colors.neutralWhite.color)
    .loading(modelData.isLoading)
    .alert(error: $modelData.error)
    .navigationBarBackButtonHidden()
    .task {
      await modelData.loadRegions()
    }
    .sheet(isPresented: $isRegionSheetPresented) {
      RegionSelectSheetView(
        regions: modelData.regions.map(\.selectItem),
        selectedRegionID: modelData.selectedRegion?.id,
        selectedDistrictID: modelData.selectedDistrict?.id,
        onSelectRegion: { modelData.selectRegion(id: $0.id) },
        onSelectDistrict: { modelData.selectDistrict(id: $0.id) },
        onApply: { isRegionSheetPresented = false }
      )
    }
    .navigationDestination(isPresented: $isPlaceSearchPresented) {
      PlaceSearchView<LocationPicker>(
        addressSearchUsecase: addressSearchUsecase,
        serviceRegionName: modelData.serviceRegionName,
        initialPlace: modelData.place
      ) { place in
        modelData.place = place
        // 검색 화면과 지도 화면을 한 번에 닫는다.
        isPlaceSearchPresented = false
      }
    }
    .navigationDestination(isPresented: $isVisitDatePresented) {
      VisitDateSelectView(initialDate: modelData.visitDate) { date in
        modelData.visitDate = date
        isVisitDatePresented = false
      }
    }
    .sheet(isPresented: $isPeriodPickerPresented) {
      CrewRoomPeriodPickerSheetView(
        initialStart: modelData.recruitStartDate ?? Date(),
        initialEnd: modelData.recruitEndDate ?? Date()
      ) { start, end in
        modelData.updateRecruitPeriod(start: start, end: end)
        isPeriodPickerPresented = false
      }
      .dynamicSheet()
    }
  }
}
