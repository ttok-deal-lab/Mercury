//
//  InterestViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Domain
import Router
import Interest
import Infrastructure

public struct InterestViewWrapperView: View, InterestViewable {
  
  let hostView: AuctionInterestView
  
  public init() {
    self.hostView = AuctionInterestView(
      interestUsecase: AuctionInterestUsecase(
        repository: AuctionInterestRepository()
      )
    )
  }
  
  public var body: some View {
    hostView
  }
}
