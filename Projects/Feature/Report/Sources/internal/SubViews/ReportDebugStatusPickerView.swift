//
//  ReportDebugStatusPickerView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

#if DEBUG
import SwiftUI

import Domain
import UIComponent

/// [DEBUG 전용] 크루장 상태를 임시로 바꿔 상태별 화면을 확인하는 드롭다운. 릴리즈 빌드에는 포함되지 않는다.
struct ReportDebugStatusPickerView: View {
  
  @Binding var status: CrewLeaderStatusType?
  
  var body: some View {
    HStack(spacing: 8) {
      Text("DEBUG")
        .fonts(.captionLargeMedium)
        .foregroundStyle(Asset.Colors.critical.color)
      
      Menu {
        Button("NONE (미신청)") { status = nil }
        ForEach(CrewLeaderStatusType.allCases, id: \.self) { item in
          Button(item.rawValue) { status = item }
        }
      } label: {
        HStack(spacing: 4) {
          Text("crewLeaderStatus: \(status?.rawValue ?? "NONE")")
            .fonts(.bodyMicroMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
          Asset.Images.chevronDown.image
            .resizable()
            .frame(width: 14, height: 14)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Asset.Colors.warningLight.color)
        .clipShape(RoundedRectangle(cornerRadius: 6))
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.top, 8)
  }
}
#endif
