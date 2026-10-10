//
//  PlaceNavigationBarView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import UIComponent

/// 주소지 검색·지도·임장날짜 화면 상단: 왼쪽 뒤로가기, 가운데 제목.
struct PlaceNavigationBarView: View {
  let title: String
  let onBack: () -> Void
  
  var body: some View {
    ZStack {
      Text(title)
        .fonts(.bodyLargeBold)
        .foregroundStyle(Asset.Colors.neutral.color)
      
      HStack {
        Button(action: onBack) {
          Asset.Images.arrowLeftNoShaft.image
            .renderingMode(.template)
            .foregroundStyle(Asset.Colors.neutral.color)
            .frame(width: 28, height: 28)
        }
        Spacer()
      }
      .padding(.horizontal, 16)
    }
    .frame(height: 56)
    .background(Asset.Colors.neutralWhite.color)
  }
}
