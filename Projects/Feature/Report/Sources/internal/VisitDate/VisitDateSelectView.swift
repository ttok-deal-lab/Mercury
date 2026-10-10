//
//  VisitDateSelectView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import UIComponent

/// 임장날짜: 달력에서 날짜, 드롭다운에서 시·분을 고르고 "선택하기".
struct VisitDateSelectView: View {
  @Environment(\.dismiss) private var dismiss
  @State private var modelData: VisitDateModelData
  private let onSelect: (Date) -> Void
  
  init(initialDate: Date?, onSelect: @escaping (Date) -> Void) {
    self.modelData = VisitDateModelData(initialDate: initialDate)
    self.onSelect = onSelect
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      PlaceNavigationBarView(title: L10n.reportCrewCreateDateLabel) {
        dismiss()
      }
      
      ScrollView(.vertical) {
        VStack(spacing: .zero) {
          VStack(alignment: .leading, spacing: 20) {
            Text(L10n.reportVisitDateSelectDate)
              .fonts(.titleMediumBold)
              .foregroundStyle(Asset.Colors.neutral.color)
            VisitDateCalendarView(modelData: modelData)
          }
          .padding(20)
          
          Rectangle()
            .fill(Asset.Colors.neutralWeak.color)
            .frame(height: 8)
          
          VStack(alignment: .leading, spacing: 16) {
            Text(L10n.reportVisitDateSelectTime)
              .fonts(.titleMediumBold)
              .foregroundStyle(Asset.Colors.neutral.color)
            HStack(spacing: 8) {
              VisitTimeDropdownView(
                placeholder: L10n.reportVisitDateHour,
                values: modelData.hours,
                selected: $modelData.hour
              )
              VisitTimeDropdownView(
                placeholder: L10n.reportVisitDateMinute,
                values: modelData.minutes,
                selected: $modelData.minute
              )
            }
          }
          .padding(20)
        }
      }
      
      bottomBar()
    }
    .background(Asset.Colors.neutralWhite.color)
    .navigationBarBackButtonHidden()
  }
  
  private func bottomBar() -> some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 2) {
        Text(L10n.reportCrewCreateDateLabel)
          .fonts(.bodyMicroRegular)
          .foregroundStyle(Asset.Colors.neutralSubtle.color)
        HStack(spacing: 4) {
          Text(modelData.selectedDayText ?? "-")
            .fonts(.bodyMediumBold)
            .foregroundStyle(Asset.Colors.neutral.color)
          Text(modelData.selectedTimeText ?? L10n.reportVisitDateSelectTime)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(modelData.selectedTimeText == nil ? Asset.Colors.neutralSubtle.color : Asset.Colors.neutral.color)
        }
      }
      
      Spacer()
      
      Button {
        guard let date = modelData.selectedDate else { return }
        onSelect(date)
      } label: {
        Text(L10n.reportVisitDateConfirm)
          .fonts(.bodyMediumBold)
          .foregroundStyle(modelData.isSelectable ? Asset.Colors.neutralWhite.color : Asset.Colors.gray300TextDisabled.color)
          .padding(.horizontal, 24)
          .frame(height: 48)
          .background(modelData.isSelectable ? Asset.Colors.primary.color : Asset.Colors.neutralWeak.color)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }
      .disabled(!modelData.isSelectable)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
    .background(Asset.Colors.neutralWhite.color)
    .overlay(alignment: .top) {
      Rectangle()
        .fill(Asset.Colors.neutralWeak.color)
        .frame(height: 1)
    }
  }
}
