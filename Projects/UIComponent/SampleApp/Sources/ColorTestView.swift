//
//  ColorTestView.swift
//  UIComponent
//
//  Created by 송하민 on 3/31/25.
//

import SwiftUI
import UIComponent

struct ColorTestView: View {
  private let testColors: [Color] = [
    Asset.Colors.backgroundDefault.color,
    Asset.Colors.backgroundMuted.color,
    Asset.Colors.borderDark.color,
    Asset.Colors.borderDefault.color,
    Asset.Colors.borderError.color,
    Asset.Colors.borderSuccess.color,
    Asset.Colors.buttonBlackDefault.color,
    Asset.Colors.buttonBlackDisabled.color,
    Asset.Colors.buttonBlackPressed.color,
    Asset.Colors.buttonGrayDefault.color,
    Asset.Colors.buttonGrayDisabled.color,
    Asset.Colors.buttonGrayPressed.color,
    Asset.Colors.buttonPrimaryDefault.color,
    Asset.Colors.buttonPrimaryDisabled.color,
    Asset.Colors.buttonPrimaryPressed.color,
    Asset.Colors.textBlack.color,
    Asset.Colors.textDefault.color,
    Asset.Colors.textDisabled.color,
    Asset.Colors.textError.color,
    Asset.Colors.textSubText.color,
    Asset.Colors.textSuccess.color,
    Asset.Colors.textWhite.color
  ]
  
  var body: some View {
    ForEach(testColors, id: \.self) { color in
      Rectangle()
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .foregroundStyle(color)
    }
  }
}
