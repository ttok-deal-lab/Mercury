//
//  ShadowTestView.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

import UIComponent

struct ShadowTestView: View {
  var body: some View {
    VStack(alignment: .center, spacing: 50) {
      Rectangle()
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 24)
        .shadows(.shadowLow)
      
      Rectangle()
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 24)
        .shadows(.shadowMediumLow)
      
      Rectangle()
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 24)
        .shadows(.shadowMedium)
      
      Rectangle()
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 24)
        .shadows(.shadowHigh)
      
      Rectangle()
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 24)
        .shadows(.shadowHighest)
    }
  }
}
