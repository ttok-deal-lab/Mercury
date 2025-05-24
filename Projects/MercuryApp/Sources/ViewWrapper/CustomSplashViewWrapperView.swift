//
//  CustomSplashViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI
import Combine

import Router
import Domain
import Infrastructure
import CustomSplash

public struct CustomSplashViewWrapperView: View, CustomSplashViewable {
  private let hostView: CustomSplashView
  
  public init(
    onComplete: @escaping (_ isUserLoggedIn: Bool) -> Void
  ) {
    self.hostView = CustomSplashView(
      onComplete: onComplete,
      localStorageUsecasable: LocalStorageUsecase(repository: UserDefaultsStoreRepository())
    )
  }
  
  public var body: some View {
    self.hostView
  }
}
