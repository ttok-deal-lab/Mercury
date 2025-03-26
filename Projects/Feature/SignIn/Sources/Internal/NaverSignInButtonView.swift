//
//  NaverSignInButtonView.swift
//  SignIn
//
//  Created by 최수훈 on 1/17/25.
//

import Foundation
import SwiftUI

import AppFoundation
import UIComponent

import NaverThirdPartyLogin

struct NaverSignInButtonView: View {
  var completion: () throws -> Void
  public var body: some View {
    Button {
      Task {
        try completion()
      }
    } label: {
      HStack {
        Image(asset: UIComponentAsset.Images.naverStandard)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .frame(width: 200, height: 50)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .padding()
    }
  }
}
