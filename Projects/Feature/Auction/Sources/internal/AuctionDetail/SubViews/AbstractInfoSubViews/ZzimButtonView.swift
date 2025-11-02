//
//  ZzimButtonView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import Domain
import UIComponent

struct ZzimButtonView: View {
  @State private var isZzimed: Bool = false
  @State private var zzimCount: Int
  private let item: AuctionDetail
  
  init(isZzimed: Bool, item: AuctionDetail) {
    self.isZzimed = isZzimed
    self.item = item
    self.zzimCount = item.zzimCount
  }
  
  var body: some View {
    VStack(spacing: 4) {
      Button {
        self.isZzimed.toggle()
        if isZzimed {
          zzimCount += 1
        } else {
          zzimCount -= 1
        }
      } label: {
        Asset.Images.heart.image
          .renderingMode(.template)
          .resizable()
          .foregroundStyle(!isZzimed ? Asset.Colors.gray150.color : Asset.Colors.red700TextError.color)
          .frame(width: 28, height: 28)
      }
      Text("\(zzimCount)")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtle.color)
      
      Spacer()
    }
  }
}
