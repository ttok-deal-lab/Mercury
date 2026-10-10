//
//  CrewLeaderApplyDetailView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import AppFoundation
import UIComponent
import Router

struct CrewLeaderApplyDetailView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData = CrewLeaderApplyDetailModelData()
  
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
          Text(L10n.reportLeaderProfileTitle)
            .fonts(.headingMiniBold)
            .foregroundStyle(Asset.Colors.neutral.color)
            .padding(.bottom, 4)
          
          CrewLeaderFormSectionView(title: L10n.reportLeaderProfileImage, isRequired: true) {
            CrewLeaderProfileImagePickerView(imageData: $modelData.profileImageData)
          }
          
          CrewLeaderFormSectionView(
            title: L10n.reportLeaderProfileReport,
            description: L10n.reportLeaderProfileReportDesc
          ) {
            CrewLeaderReportFilePickerView(fileURL: $modelData.reportFileURL)
          }
          
          CrewLeaderFormSectionView(title: L10n.reportLeaderProfileIntro) {
            CrewLeaderIntroEditorView(
              text: $modelData.introduction,
              placeholder: L10n.reportLeaderProfileIntroPlaceholder
            )
          }
          
          CrewLeaderFormSectionView(
            title: L10n.reportLeaderProfileLink,
            isRequired: true,
            description: L10n.reportLeaderProfileLinkDesc
          ) {
            CrewLeaderLinkListView(links: $modelData.links) {
              modelData.addLink()
            }
          }
          
          CrewLeaderFormSectionView(
            title: L10n.reportLeaderProfileContact,
            isRequired: true,
            description: L10n.reportLeaderProfileContactDesc
          ) {
            CrewLeaderTextFieldView(
              text: $modelData.contact,
              placeholder: L10n.reportLeaderProfileContactPlaceholder,
              isPhoneNumber: true
            )
          }
          
          CrewLeaderFormSectionView(
            title: L10n.reportLeaderProfileCareer,
            description: L10n.reportLeaderProfileCareerDesc
          ) {
            CrewLeaderTextFieldView(
              text: $modelData.career,
              placeholder: L10n.reportLeaderProfileCareerPlaceholder
            )
          }
        }
        .padding(.horizontal, 20)
        .padding(.top, 19)
        .padding(.bottom, 24)
      }
      .scrollDismissesKeyboard(.interactively)
      
      MercuryButton(L10n.reportLeaderProfileSubmit) {
        Task {
          guard await modelData.submit() else { return }
          // 완료 화면에서 뒤로가기로 폼에 돌아오지 않도록 스택을 완료 화면 하나로 교체한다.
          coordinator.replaceStack(with: .report(ReportRoute(route: .crewLeaderApplyComplete)))
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
  }
}
