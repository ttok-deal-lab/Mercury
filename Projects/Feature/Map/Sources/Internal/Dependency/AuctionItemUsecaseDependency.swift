//
//  MarkderUsecaseDependency.swift
//  Map
//
//  Created by 송하민 on 8/14/24.
//

import Foundation
import ComposableArchitecture
import DomainInterface
import Domain

private enum AuctionItemUsecaseKey: DependencyKey {
  static let liveValue: AuctionItemUsecase = AuctionItemUsecaseImplement()
//  static let testValue: AuctionItemUsecase = StubAuctionItemUsecaseImplement()
}

extension DependencyValues {
  var auctionItemUsecase: AuctionItemUsecase {
    get { self[AuctionItemUsecaseKey.self] }
    set { self[AuctionItemUsecaseKey.self] = newValue }
  }
}
