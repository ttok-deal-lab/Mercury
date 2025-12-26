//
//  RecentSalesModelData.swift
//  MyPage
//
//  Created by 최수훈 on 12/26/25.
//

import SwiftUI
import Combine

import Domain

@Observable
public final class RecentSalesModelData {
  // MARK: - internal property
  
  // MARK: - private property
  private let localStorageUsecase: LocalStorageUsecasable
  
  // MARK: - life cycle
  
  public init(localStorageUsecase: LocalStorageUsecasable) {
    self.localStorageUsecase = localStorageUsecase
  }
}
