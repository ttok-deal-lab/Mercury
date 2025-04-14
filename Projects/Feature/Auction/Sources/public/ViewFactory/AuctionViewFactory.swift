//
//  AuctionFactory.swift
//  Auction
//
//  Created by 송하민 on 12/29/24.
//

import Foundation
import SwiftUI
import Combine

import Router
import Domain


public struct AuctionViewFactory: ViewFactory {
  
  public init() {}
  
  public func makeView(_ route: AuctionRoute, navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) -> some View {
    EmptyView()
  }
}
