//
//  CrewRoomCreateView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import AppFoundation
import UIComponent
import Router

struct CreateCrewFormView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData = CrewRoomCreateModelData()
  @State private var isVisitDatePickerPresented: Bool = false
  @State private var isPeriodPickerPresented: Bool = false
  
  init() { }
  
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
            CrewRoomChipButtonView(title: modelData.region ?? L10n.reportCrewCreateRegionSelect) {
              // 지역 선택 UI 가 확정되면 연결한다.
            }
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreatePlaceLabel, isRequired: true) {
            VStack(alignment: .leading, spacing: 8) {
              CrewRoomChipButtonView(title: modelData.place ?? L10n.reportCrewCreatePlaceSelect) {
                // 장소 선택 UI 가 확정되면 연결한다.
              }
              
              CrewLeaderTextFieldView(text: $modelData.address, placeholder: L10n.reportCrewCreateAddressPlaceholder)
            }
          }
          
          CrewLeaderFormSectionView(title: L10n.reportCrewCreateDateLabel, isRequired: true) {
            CrewRoomDateFieldView(text: modelData.visitDateText, placeholder: L10n.reportCrewCreateDatePlaceholder) {
              isVisitDatePickerPresented = true
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
    .sheet(isPresented: $isVisitDatePickerPresented) {
      CrewRoomDatePickerSheetView(initialDate: modelData.visitDate ?? Date()) { date in
        modelData.visitDate = date
        isVisitDatePickerPresented = false
      }
      .dynamicSheet()
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
