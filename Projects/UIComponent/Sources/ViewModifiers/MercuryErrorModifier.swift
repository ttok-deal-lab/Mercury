//
//  MercuryErrorModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/14/25.
//

import SwiftUI
import Combine

import AppFoundation

struct MercuryErrorModifier: ViewModifier {
  @Binding var mercuryError: MercuryError?
  var completion: (() -> Void)?
  
  func body(content: Content) -> some View {
    content
      .onReceive(Just(mercuryError)) { newValue in
        guard let error = newValue else { return }
        MercuryAlert.shared
          .present(
            type: .confirmable(
              information: AlertConfirmInformation(
                title: "에러",
                description: error.description,
                confirmButtonTitle: "확인",
                onConfirm: {
                  self.mercuryError = nil
                  completion?()
                }
              )
            )
          )
      }
  }
}

public extension View {
  func alert(error: Binding<MercuryError?>, completion: (() -> Void)? = nil) -> some View {
    self.modifier(MercuryErrorModifier(mercuryError: error, completion: completion))
  }
}
