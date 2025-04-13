//
//  AuctionHomeViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Auction

public struct AuctionHomeViewWrapperView: View, AuctionHomeViewable {
  
  let hostView: AuctionHomeView
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.hostView = AuctionHomeView(navigationSubject: navigationSubject)
  }
  
  public var body: some View {
    hostView
  }
}
