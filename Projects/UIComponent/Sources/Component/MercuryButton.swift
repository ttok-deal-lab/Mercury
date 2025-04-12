//
//  MercuryButton.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

public struct MercuryButton: View {
  private let title: String
  private let completion: () -> Void
  
  public init(_ title: String, completion: @escaping () -> Void) {
    self.title = title
    self.completion = completion
  }
  
  public var body: some View {
    Button {
      completion()
    } label: {
      Text(title)
        .fonts(.bodyLargeBold)
        .foregroundStyle(Asset.Colors.textWhite.color)
    }

  }
}

