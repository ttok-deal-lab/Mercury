//
//  AppleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import Combine

import UIComponent
import AppFoundation
import Domain
import Router

public struct SignInView: View {
  @StateObject private var signInModelData: SignInModelData
  @State private var error: MercuryError?
  
  let navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    serviceSignInUsecasable: ServiceSignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self.navigationSubject = navigationSubject
    self._signInModelData = StateObject(
      wrappedValue: SignInModelData(
        serviceSignInUsecasable: serviceSignInUsecasable,
        localStorageUsecasable: localStorageUsecasable
      )
    )
  }
  
  public var body: some View {
    ZStack {
      VStack(spacing: .zero) {
        Spacer()
        Asset.Images.slugWithTitle.image
        Spacer()
        
        VStack(spacing: 8) {
          ForEach(OauthProvider.allCases) { type in
            SignInButtonView(type: type) {
              await handleSignIn(with: type)
            }
            .padding(.horizontal, 20)
          }
        }
        .padding(.bottom, 50)
      }
      
    }
    .windowCover(isPresented: Binding(get: { error != nil }, set: { _ in })) {
      MercuryAlert(
        isPresented: Binding(get: { error != nil }, set: { _ in }),
        type: .confirmable(information: AlertConfirmInformation(title: "문제가 발생했습니다.", description: "\(error?.description ?? "")", confirmButtonTitle: "확인", onConfirm: { error = nil })))
    }
  }
  
  @MainActor
  private func handleSignIn(with provider: OauthProvider) async {
    do {
      try await signInModelData.oauthSignIn(provider)
      navigationSubject.send(.dismissFullScreen)
    } catch let error as MercuryError  {
      self.error = error
    } catch {
      self.error = MercuryError(.unknown)
    }
  }
}
