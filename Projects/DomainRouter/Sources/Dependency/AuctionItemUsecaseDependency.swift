//
//  MarkderUsecaseDependency.swift
//  Map
//
//  Created by 송하민 on 8/14/24.
//

import Foundation
import ComposableArchitecture
import Domain
import DomainInterface

public enum AuctionItemUsecaseKey: DependencyKey {
  public static let liveValue: AuctionItemUsecase = AuctionItemUsecaseImplement()
}

extension DependencyValues {
  public var auctionItemUsecase: AuctionItemUsecase {
    get { self[AuctionItemUsecaseKey.self] }
    set { self[AuctionItemUsecaseKey.self] = newValue }
  }
}
