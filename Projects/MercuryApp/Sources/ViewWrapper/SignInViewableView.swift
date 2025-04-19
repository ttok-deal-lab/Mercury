//
//  SignInViewable.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Onboard
import Domain
import Infrastructure

public struct SignInViewWrapperView: View, SignInViewable {
  
  let hostView: SignInView
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.hostView = SignInView(
      navigationStream: navigationStream,
      serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
      localStorageUsecasable: LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
    )
  }
  
  public var body: some View {
    hostView
  }
}
