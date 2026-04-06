//
//  AuctionDetailModelData.swift
//  Auction
//
//  Created by 송하민 on 11/1/25.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

import AppFoundation
import Domain
import Infrastructure

@Observable
@MainActor
public final class AuctionDetailModelData {
  
  // MARK: - internal properties
  
  var error: Error?
  var auctionDetailItem: AuctionDetail?
  var isLoading: Bool = false
  var isLoadingMapCoordinate: Bool = false
  var isLoadingZzim: Bool = false
  var mapCoordinate: CLLocationCoordinate2D?
  var isZzimed: Bool = false
  var zzimCount: Int = 0
  
  // MARK: - private properties
  
  private let auctionID: Int
  private let fetchAuctionDetail: (Int) async throws -> AuctionDetail
  private let loadAuctionInterestState: (Int) async throws -> Bool
  private let addUserInterestAuction: (Int) async throws -> Void
  private let removeUserInterestAuction: (Int) async throws -> Void
  private let coordinateResolver: any AuctionDetailCoordinateResolving
  
  // MARK: - life cycle
  
  public init(
    auctionDetailUsecase: AuctionDetailUsecase,
    auctionInterestUsecase: any AuctionInterestUsecasable,
    auctionID: Int
  ) {
    self.fetchAuctionDetail = auctionDetailUsecase.fetchAuctionDetail
    self.loadAuctionInterestState = auctionInterestUsecase.isAuctionUserInterested
    self.addUserInterestAuction = auctionInterestUsecase.addUserInterestAuction
    self.removeUserInterestAuction = auctionInterestUsecase.removeUserInterestAuction
    self.coordinateResolver = LiveAuctionDetailCoordinateResolver()
    self.auctionID = auctionID
    Task { [weak self] in
      await self?.loadAuctionDetail()
    }
  }

  init(
    auctionID: Int,
    fetchAuctionDetail: @escaping (Int) async throws -> AuctionDetail,
    loadAuctionInterestState: @escaping (Int) async throws -> Bool,
    addUserInterestAuction: @escaping (Int) async throws -> Void,
    removeUserInterestAuction: @escaping (Int) async throws -> Void,
    coordinateResolver: any AuctionDetailCoordinateResolving
  ) {
    self.fetchAuctionDetail = fetchAuctionDetail
    self.loadAuctionInterestState = loadAuctionInterestState
    self.addUserInterestAuction = addUserInterestAuction
    self.removeUserInterestAuction = removeUserInterestAuction
    self.coordinateResolver = coordinateResolver
    self.auctionID = auctionID
    Task { [weak self] in
      await self?.loadAuctionDetail()
    }
  }
  
  // MARK: - internal methods
  
  func sortedSalesDetailByTime() -> [AuctionDetail.SalesDetail] {
    self.auctionDetailItem?.salesDetails.sorted { $0.timeStamp > $1.timeStamp } ?? []
  }
  
  func tapOnZzim() async {
    let previousIsZzim = self.isZzimed
    let previousCount = self.zzimCount
    
    self.isLoadingZzim = true
    defer {
      self.isLoadingZzim = false
    }
    
    do {
      if previousIsZzim {
        try await self.removeUserInterestAuction(self.auctionID)
        self.isZzimed = false
        self.zzimCount = max(0, previousCount - 1)
      } else {
        try await self.addUserInterestAuction(self.auctionID)
        self.isZzimed = true
        self.zzimCount = previousCount + 1
      }
      NotificationCenter.default.post(
        name: .auctionZzimDidChange,
        object: nil,
        userInfo: [
          AuctionZzimChangeUserInfoKey.auctionID: self.auctionID,
          AuctionZzimChangeUserInfoKey.isZzimed: self.isZzimed,
          AuctionZzimChangeUserInfoKey.zzimCount: self.zzimCount
        ]
      )
    } catch let error as MercuryError {
      self.isZzimed = previousIsZzim
      self.zzimCount = previousCount
      self.error = error
    } catch {
      self.isZzimed = previousIsZzim
      self.zzimCount = previousCount
      self.error = error
    }
  }
  
  // MARK: - private methods
  
  private func loadAuctionDetail() async {
    do {
      let item = try await self.fetchAuctionDetailItem()
      self.auctionDetailItem = item
      self.zzimCount = item.zzimCount
      
      async let mapTask: Void = self.loadMapCoordinate(for: item)
      async let interestTask: Void = self.loadInterestState()
      _ = await (mapTask, interestTask)
    } catch let error as MercuryError {
      self.error = error
    } catch {
      self.error = error
    }
  }

  private func fetchAuctionDetailItem() async throws -> AuctionDetail {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    return try await self.fetchAuctionDetail(self.auctionID)
  }

  private func loadMapCoordinate(for auctionDetail: AuctionDetail) async {
    self.isLoadingMapCoordinate = true
    defer {
      self.isLoadingMapCoordinate = false
    }

    let addresses = Self.candidateMapAddresses(for: auctionDetail)
    self.mapCoordinate = await self.coordinateResolver.resolveCoordinate(
      courtName: auctionDetail.court.name,
      addresses: addresses
    )
  }
  
  private func loadInterestState() async {
    self.isLoadingZzim = true
    defer {
      self.isLoadingZzim = false
    }
    
    do {
      self.isZzimed = try await self.loadAuctionInterestState(self.auctionID)
    } catch let error as MercuryError {
      self.error = error
    } catch {
      self.error = error
    }
  }

  static func candidateMapAddresses(for auctionDetail: AuctionDetail) -> [String] {
    let detailAddresses = auctionDetail.salesBuildings.flatMap { building -> [String] in
      let detailedAddress = [building.address.full, building.detailAddress]
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
        .joined(separator: " ")

      return [detailedAddress, building.address.full]
    }

    return Self.deduplicatedAddresses([auctionDetail.salesAddress] + detailAddresses)
  }

  private static func deduplicatedAddresses(_ addresses: [String]) -> [String] {
    var uniqueAddresses: [String] = []

    for address in addresses {
      let trimmedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
      guard !trimmedAddress.isEmpty, !uniqueAddresses.contains(trimmedAddress) else {
        continue
      }
      uniqueAddresses.append(trimmedAddress)
    }

    return uniqueAddresses
  }
}

protocol AuctionDetailCoordinateResolving {
  func resolveCoordinate(courtName: String, addresses: [String]) async -> CLLocationCoordinate2D?
}

struct LiveAuctionDetailCoordinateResolver: AuctionDetailCoordinateResolving {
  private let productCoordinateService = ProductCoordinateService()
  
  func resolveCoordinate(courtName: String, addresses: [String]) async -> CLLocationCoordinate2D? {
    let geocoder = CLGeocoder()

    for address in addresses {
      guard !Task.isCancelled else { return nil }
      
      if let coordinate = await productCoordinateService.coordinate(name: courtName, address: address) {
        return coordinate
      }

      do {
        let placemarks = try await geocoder.geocodeAddressString(address)
        if let coordinate = placemarks.first?.location?.coordinate {
          return coordinate
        }
      } catch {
        continue
      }
    }

    return nil
  }
}

private enum AuctionZzimChangeUserInfoKey {
  static let auctionID = "auctionID"
  static let isZzimed = "isZzimed"
  static let zzimCount = "zzimCount"
}
