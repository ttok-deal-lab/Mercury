//
//  AnalysisView.swift
//  Analysis
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

import Domain
import Router
import UIComponent

public struct SearchView: View {
  enum SearchScreenType {
    /// 최근 검색어
    case latestSearchedText
    /// 추천 검색어
    case recommandSearching
    /// 검색함
    case userSearched
  }
  
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var searchModelData: SearchModelData
  @State private var searchText: String = ""
  @State private var screenType: SearchScreenType = .latestSearchedText
  @State private var isSelectingRecentSearch: Bool = false
  private let initialKeyword: String?
  @State private var didApplyInitialKeyword: Bool = false

  public init(
    auctionSalesListUsecase: AuctionSalesListUsecase,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    localStorageUsecase: LocalStorageUsecase,
    initialKeyword: String? = nil
  ) {
    self._searchModelData = State(
      initialValue: SearchModelData(
        auctionSalesListUsecase: auctionSalesListUsecase,
        auctionSearchFilterUsecase: auctionSearchFilterUsecase,
        localStorageUsecase: localStorageUsecase
      )
    )
    self.initialKeyword = initialKeyword
  }

  public var body: some View {
    VStack(spacing: .zero) {
      SearchNavigationBar(
        text: $searchText,
        onClose: {
          coordinator.popToRoot()
        },
        onBack: {
          coordinator.pop()
        }
      )
      
      Rectangle()
        .foregroundStyle(Asset.Colors.neutralLight.color)
        .frame(height: 1)
        .frame(maxWidth: .infinity)
      
      searchScreen()
      
      Spacer()
    }
    .ignoresSafeArea(edges: [.bottom])
    .navigationBarBackButtonHidden()
    .submitLabel(.search)
    .onSubmit {
      self.screenType = .userSearched
      searchModelData.search(with: searchText)
    }
    .onChange(of: searchText, { oldValue, newValue in
      if isSelectingRecentSearch {
        isSelectingRecentSearch = false
        return
      }
      guard oldValue != newValue else { return }
      if newValue.isEmpty {
        screenType = .latestSearchedText
      } else {
        screenType = .recommandSearching
        searchModelData.typing()
      }
    })
    .alert(error: $searchModelData.error)
    .loading(searchModelData.isLoading)
    .environment(searchModelData)
    .onAppear(perform: applyInitialKeywordIfNeeded)
  }

  // 딥링크로 keyword 를 받고 진입한 경우, 최근검색 선택과 동일한 플로우로 결과까지 바로 노출한다.
  private func applyInitialKeywordIfNeeded() {
    guard
      !didApplyInitialKeyword,
      let keyword = initialKeyword,
      !keyword.trimmingCharacters(in: .whitespaces).isEmpty
    else { return }
    didApplyInitialKeyword = true
    isSelectingRecentSearch = true
    screenType = .userSearched
    searchText = keyword
    searchModelData.search(with: keyword)
  }

  @ViewBuilder
  private func searchScreen() -> some View {
    switch self.screenType {
    case .latestSearchedText:
      SearchLatestSearchView { searchedText in
        isSelectingRecentSearch = true
        screenType = .userSearched
        searchText = searchedText
        searchModelData.search(with: searchedText)
      }
    case .recommandSearching:
      EmptyView()
    case .userSearched:
      if !searchModelData.isLoading,
         searchModelData.auctionSalesItems.isEmpty {
        NoSearchResultView()
      } else {
        VStack(spacing: .zero) {
          SearchAuctionFilterView()
          SearchAuctionSortView()
          ScrollView(.vertical) {
            ForEach(searchModelData.auctionSalesItems) { item in
              Button {
                coordinator.push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: item.id))))
              } label: {
                SearchAuctionSalesItemView(item: item, onZzim: {
                  // 찜 했을때의 액션
                })
              }
            }
          }
        }
      }
    }
  }
}

fileprivate struct NoSearchResultView: View {
  var body: some View {
    VStack(spacing: .zero) {
      Spacer()
      VStack(spacing: .zero) {
        Asset.Images.infoLine.image
          .resizable()
          .frame(width: 50, height: 50)
          .padding(.bottom, 12)
        
        Text("검색 결과가 없어요")
          .fonts(.bodySmallBold)
          .foregroundStyle(Asset.Colors.gray600.color)
          .padding(.bottom, 4)
        
        Text("검색어를 한 글자 이상 작성해주세요")
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
      Spacer()
      Spacer()
    }
  }
}
