//
//  AuctionRow.swift
//  AuctionSampleApp
//
//  Created by 최수훈 on 11/9/24.
//

import Foundation
import SwiftUI

public struct AuctionRow: View {
  
  public var auctionInfo: AuctionList?
  
  public var body: some View {
    VStack(alignment: .leading) {
      Text("sales ID : \(auctionInfo?.id ?? "")")
      Text("courtName : \(auctionInfo?.name ?? "")")
      Text("saledsNumber : \(auctionInfo?.salesNum ?? 0)")
    }
  }
}
