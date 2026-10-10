//
//  ReportViewFactory.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import Foundation
import SwiftUI

import Domain
import Router

/// LocationPicker: 지도에서 위치 선택에 쓰는 지도 뷰 (앱에서는 Map 모듈 구현을 주입)
public struct ReportViewFactory<LocationPicker: LocationPickerMapViewable>: ViewFactory {
  
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  private let addressSearchUsecase: AddressSearchUsecasable
  
  public init(
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    addressSearchUsecase: AddressSearchUsecasable
  ) {
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
    self.addressSearchUsecase = addressSearchUsecase
  }
  
  public func makeView(_ reportRouter: ReportRoute) -> some View {
    switch reportRouter.route {
    case .crewLeaderApply:
      CrewLeaderApplyView()
    case .crewLeaderApplyDetail:
      CrewLeaderApplyDetailView()
    case .crewLeaderApplyComplete:
      CrewLeaderApplyCompleteView()
    case .createCrewRoom:
      CreateCrewFormView<LocationPicker>(
        auctionSearchFilterUsecase: auctionSearchFilterUsecase,
        addressSearchUsecase: addressSearchUsecase
      )
    }
  }
}
