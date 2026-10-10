//
//  VisitDateCalendarView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import UIComponent

/// 월 달력. 지난 날짜는 회색·선택 불가, 오늘은 아래 점, 선택일은 파란 원.
struct VisitDateCalendarView: View {
  let modelData: VisitDateModelData
  
  private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
  
  var body: some View {
    VStack(spacing: 20) {
      HStack(spacing: 20) {
        Button {
          modelData.moveMonth(by: -1)
        } label: {
          Asset.Images.arrowLeftNoShaft.image
            .renderingMode(.template)
            .foregroundStyle(modelData.canMoveToPreviousMonth ? Asset.Colors.neutral.color : Asset.Colors.neutralMuted.color)
        }
        .disabled(!modelData.canMoveToPreviousMonth)
        
        Text(modelData.monthTitle)
          .fonts(.titleLargeBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        
        Button {
          modelData.moveMonth(by: 1)
        } label: {
          Asset.Images.arrowRightNoShaft.image
            .renderingMode(.template)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
      }
      
      LazyVGrid(columns: columns, spacing: 8) {
        ForEach(Array(modelData.weekdaySymbols.enumerated()), id: \.offset) { index, symbol in
          Text(symbol)
            .fonts(.bodySmallMedium)
            .foregroundStyle(weekdayColor(column: index))
            .frame(height: 32)
        }
        
        ForEach(Array(modelData.dayCells.enumerated()), id: \.offset) { _, day in
          if let day {
            dayCell(day)
          } else {
            Color.clear.frame(height: 44)
          }
        }
      }
    }
  }
  
  private func dayCell(_ day: Date) -> some View {
    let isSelected = modelData.isSelected(day)
    let isPast = modelData.isPast(day)
    return Button {
      modelData.select(day)
    } label: {
      VStack(spacing: 2) {
        Text("\(modelData.calendar.component(.day, from: day))")
          .fonts(.bodyMediumMedium)
          .foregroundStyle(dayColor(day, isSelected: isSelected, isPast: isPast))
          .frame(width: 40, height: 40)
          .background(isSelected ? Asset.Colors.primary.color : .clear)
          .clipShape(Circle())
        Circle()
          .fill(modelData.isToday(day) && !isSelected ? Asset.Colors.primary.color : .clear)
          .frame(width: 4, height: 4)
      }
    }
    .disabled(isPast)
  }
  
  private func weekdayColor(column: Int) -> Color {
    let weekday = (column + modelData.calendar.firstWeekday - 1) % 7 + 1
    switch weekday {
    case 1: return Asset.Colors.critical.color
    case 7: return Asset.Colors.primary.color
    default: return Asset.Colors.neutral.color
    }
  }
  
  private func dayColor(_ day: Date, isSelected: Bool, isPast: Bool) -> Color {
    if isSelected { return Asset.Colors.neutralWhite.color }
    if isPast { return Asset.Colors.neutralMuted.color }
    return Asset.Colors.neutral.color
  }
}
