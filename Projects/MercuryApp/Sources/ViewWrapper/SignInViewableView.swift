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
  
  private let hostView: SignInView
  
  public init(onComplete: (() -> Void)?) {
    self.hostView = SignInView(
      onComplete: onComplete,
      serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
      locationUsecasable: LocationUsecase()
    )
  }
  
  public var body: some View {
    hostView
  }
}
