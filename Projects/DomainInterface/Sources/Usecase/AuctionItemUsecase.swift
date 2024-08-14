//
//  AuctionItemUsecase.swift
//  DomainInterface
//
//  Created by 송하민 on 8/13/24.
//

import CoreLocation
import AppFoundation

public protocol AuctionItemUsecase {
  
  func loadAuctionItems() async -> Result<[AuctionItem], MercuryError>
  
}
