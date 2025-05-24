//
//  InformCertificationView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct InformCertificationView: View {
  var body: some View {
    VStack(spacing: .zero) {
      
      VStack(spacing: 5) {
        HStack(spacing: 4) {
          Asset.Images.certified.image
            .resizable()
            .frame(width: 22, height: 22)
          HStack(spacing: .zero) {
            Text("인증매물")
              .foregroundStyle(Asset.Colors.primary200TextSuccess.color)
              .fonts(.bodyMediumBold)
            Text("이란")
              .foregroundStyle(Asset.Colors.gray700TextDefault.color)
              .fonts(.bodyMediumBold)
          }
          Spacer()
        }
        
        HStack(spacing: .zero) {
          Text("임장보고서가 존재해 정확한 정보를 확인할 수 있어요.")
            .foregroundStyle(Asset.Colors.gray400TextSubText.color)
            .fonts(.bodyMiniMedium)
          Spacer()
        }
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 20)
      
    }
    .background(Asset.Colors.gray50BackgroundMuted.color)
  }
}
