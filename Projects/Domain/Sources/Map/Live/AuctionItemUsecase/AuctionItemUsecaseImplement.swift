//
//  AuctionItemUsecaseImplement.swift
//  Domain
//
//  Created by 송하민 on 8/14/24.
//

import Foundation
import AppFoundation
import DomainInterface
import CoreLocation

public class AuctionItemUsecaseImplement: AuctionItemUsecase {
  
  public init() {
    
  }
  
  public func loadAuctionItems() async -> Result<[AuctionItem], MercuryError> {
    return .success([
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583237, longitude: 126.932912), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583238, longitude: 126.932913), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583239, longitude: 126.932914), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583240, longitude: 126.932915), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583241, longitude: 126.932916), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583242, longitude: 126.932917), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583243, longitude: 126.932918), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583244, longitude: 126.932919), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583245, longitude: 126.932920), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583246, longitude: 126.932921), auctionType: .personal),
      AuctionItem(coordinate: CLLocationCoordinate2D(latitude: 37.3583247, longitude: 126.932922), auctionType: .personal)
    ])
  }
}
