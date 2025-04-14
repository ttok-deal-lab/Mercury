//
//  MercuryButton.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

public struct MercuryButton: View {
  public enum ButtonType {
    case primary
    case secondary
    
    var backgroundColor: Color {
      switch self {
      case .primary:
        Asset.Colors.primary200ButtonPrimaryDefault.color
      case .secondary:
        Asset.Colors.gray100ButtonGrayDefault.color
      }
    }
    
    var textColor: Color {
      switch self {
      case .primary:
        Asset.Colors.gray10TextWhite.color
      case .secondary:
        Asset.Colors.gray900TextBlack.color
      }
    }
  }
  
  // MARK: - private property
  
  private let type: ButtonType
  private let title: String
  private let completion: () -> Void
  
  // MARK: - life cycle
  
  public init(
    type: ButtonType = .primary,
    _ title: String,
    completion: @escaping () -> Void
  ) {
    self.type = type
    self.title = title
    self.completion = completion
  }
  
  public var body: some View {
    Button {
      completion()
    } label: {
      Text(title)
        .fonts(.bodyLargeBold)
        .foregroundStyle(type.textColor)
        .frame(maxWidth: .infinity, minHeight: 56)
        .background(type.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
  }
}

#Preview {
  MercuryButton(
    "이것은 확인버튼입니다."
  ) {
  }
  
  MercuryButton(
    type: .secondary,
    "이것은 확인버튼입니다."
  ) {
  }
}

