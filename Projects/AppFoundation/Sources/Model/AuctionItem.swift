//
//  AuctionItem.swift
//  AppFoundation
//
//  Created by 송하민 on 8/14/24.
//

import Foundation
import CoreLocation

public enum AuctionType {
  /// 공매
  case `public`
  /// 경매
  case personal
}

public struct AuctionItem {
  var coordinate: CLLocationCoordinate2D
  var auctionType: AuctionType
  
  public init(coordinate: CLLocationCoordinate2D, auctionType: AuctionType) {
    self.coordinate = coordinate
    self.auctionType = auctionType
  }
}


