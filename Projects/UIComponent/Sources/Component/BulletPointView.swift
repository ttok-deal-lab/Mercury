//
//  BulletPointView.swift
//  UIComponent
//
//  Created by 최수훈 on 1/1/26.
//

import SwiftUI

public struct BulletPointView: View {
  public var text: String
  public var fonts: MercuryFont
  public var color: Color
  
  public init(text: String, fonts: MercuryFont, color: Color) {
    self.text = text
    self.fonts = fonts
    self.color = color
  }
  
  public var body: some View {
    HStack(alignment: .firstTextBaseline, spacing: 6) {
      Text("•")
        .fonts(fonts)
        .foregroundColor(color)
        .padding(.leading, 4)
      
      Text(text)
        .fonts(fonts)
        .foregroundStyle(color)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
