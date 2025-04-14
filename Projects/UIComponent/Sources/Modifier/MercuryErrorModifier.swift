//
//  MercuryErrorModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/14/25.
//

import SwiftUI

import AppFoundation

struct MercuryErrorModifier: ViewModifier {
  @Binding var mercuryError: MercuryError?
  var completion: (() -> Void)?
  
  func body(content: Content) -> some View {
    content
      .onChange(of: mercuryError) { oldValue, newValue in
        guard oldValue != newValue else { return }
        MercuryAlert.shared
          .present(
            type: .confirmable(
              information: AlertConfirmInformation(
                title: "에러",
                description: newValue?.description ?? "",
                confirmButtonTitle: "확인",
                onConfirm: {
                  completion?()
                }
              )
            )
          )
      }
  }
}

public extension View {
  func mercuryError(error: Binding<MercuryError?>, completion: (() -> Void)? = nil) -> some View {
    self.modifier(MercuryErrorModifier(mercuryError: error, completion: completion))
  }
}
