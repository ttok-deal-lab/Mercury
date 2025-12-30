//
//  SearchLatestSearchView.swift
//  Search
//
//  Created by 송하민 on 12/28/25.
//

import SwiftUI

import UIComponent
import Router

struct SearchLatestSearchView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @Environment(SearchModelData.self) var modelData
  var onTapLatestSearch: (String) -> Void
  
  var body: some View {
    VStack(spacing: .zero) {
      if modelData.latestSearchTexts.isEmpty {
        NoResultView()
      } else {
        HStack(spacing: .zero) {
          Text("최근 검색어")
            .fonts(.titleMediumBold)
            .foregroundStyle(Asset.Colors.neutral.color)
          Spacer()
          Button {
            modelData.removeAllLatestSearchText()
          } label: {
            Text("전체삭제")
              .fonts(.bodyMicroMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
          }
        }
        .padding(EdgeInsets(top: 24, leading: 20, bottom: 8, trailing: 20))
        
        ForEach(modelData.latestSearchTexts, id: \.self) { searchedText in
          HStack(spacing: .zero) {
            Button {
              onTapLatestSearch(searchedText)
            } label: {
              Asset.Images.clock.image
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundStyle(Asset.Colors.neutralMuted.color)
                .padding(.trailing, 10)
              
              Text(searchedText)
                .fonts(.bodyMiniMedium)
                .foregroundStyle(Asset.Colors.neutral.color)
              
              Spacer()
            }
            
            Button {
              modelData.removeLatestSearchText(text: searchedText)
            } label: {
              Asset.Images.close.image
                .renderingMode(.template)
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundStyle(Asset.Colors.neutralSubtle.color)
                .frame(width: 20, height: 20)
                .contentShape(Rectangle())
            }
          }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
      }
    }
  }
}

fileprivate struct NoResultView: View {
  var body: some View {
    VStack(spacing: .zero) {
      Spacer()
      VStack(spacing: .zero) {
        Asset.Images.dot3Circle.image
          .resizable()
          .frame(width: 50, height: 50)
          .padding(.bottom, 12)
        
        Text("최근 검색 내역이 없어요")
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
      Spacer()
      Spacer()
    }
  }
}
