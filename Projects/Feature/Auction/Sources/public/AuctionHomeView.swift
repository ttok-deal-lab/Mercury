//
//  AuctionHomeView.swift
//  Auction
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import UIComponent

public struct AuctionHomeView: View {
  let navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationSubject = navigationSubject
  }
  
  public var body: some View {
    Text("AuctionHomeView")
  }
}
