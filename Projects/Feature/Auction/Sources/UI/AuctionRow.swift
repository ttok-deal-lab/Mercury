//
//  AuctionRow.swift
//  AuctionSampleApp
//
//  Created by 최수훈 on 11/9/24.
//

import Foundation
import SwiftUI

import Auction

public struct AuctionRow: View {
    
    public var auctionInfo: AuctionInfo?
    
    public var body: some View {
        VStack (alignment: .leading) {
            Text("sales ID : \(auctionInfo?.id ?? "")")
            Text("courtName : \(auctionInfo?.name ?? "")")
            Text("saledsNumber : \(auctionInfo?.salesNum ?? 0)")
        }
    }
}
