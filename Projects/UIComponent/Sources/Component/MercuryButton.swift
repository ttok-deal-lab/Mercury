//
//  MercuryButton.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

public struct MercuryButton: View {
  // MARK: - private property
  @Binding private var onDisabled: Bool
  private let title: String
  private let completion: () -> Void
  
  // MARK: - life cycle
  public init(
    _ title: String,
    onDisable: Binding<Bool>,
    completion: @escaping () -> Void
  ) {
    self.title = title
    self._onDisabled = onDisable
    self.completion = completion
  }
  
  public var body: some View {
    Button {
      completion()
    } label: {
      Text(title)
        .fonts(.bodyLargeBold)
        .padding(.horizontal, 24)
        .frame(height: 56)
        .foregroundStyle(Asset.Colors.textWhite.color)
        .background(
          onDisabled
          ? Asset.Colors.buttonPrimaryDisabled.color
          : Asset.Colors.buttonPrimaryDefault.color
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    .disabled(onDisabled) 
  }
}

#Preview {
  MercuryButton(
    "이것은 확인버튼입니다.",
    onDisable: .constant(false)
  ) {
  }
}

