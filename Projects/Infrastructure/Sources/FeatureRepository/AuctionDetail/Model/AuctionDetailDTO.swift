//
//  AuctionDetailDTO.swift
//  Infrastructure
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

import Domain

struct AuctionDetailDTO: Decodable, Sendable {
  let id: Int
  let salesNumber: String
  let itemTypes: [String]
  let appraisalPrice: Int
  let lowestSalesPrice: Int
  let bidType: String
  let salesDateTime: String
  let salesLocation: String
  let salesNote: String
  let salesReceptionDate: String
  let salesOpenDate: String
  let distributionRequiredDeadlineDate: String
  let salesAddress: String
  let salesCategories: [String]
  let failBidCount: Int
  let zzimCount: Int
  let courtCode: String
  let courtTeam: String
  let salesDetails: [SalesDetailDTO]
  let salesPictures: [SalesPictureDTO]
  let salesBuildings: [SalesBuildingDTO]
  let salesItemDetails: [SalesItemDetailDTO]
  let conditionReport: ConditionReportDTO
  let appraisalDocumentUrl: String
  let appraisalDocuments: [AppraisalDocumentDTO]
  let nearbySalesStats: [NearbySalesStatDTO]
  let soldOut: Bool
  
  enum CodingKeys: String, CodingKey {
    case id, salesNumber, itemTypes, appraisalPrice, lowestSalesPrice
    case bidType, salesDateTime, salesLocation, salesNote
    case salesReceptionDate, salesOpenDate, distributionRequiredDeadlineDate
    case salesAddress, salesCategories, failBidCount, zzimCount
    case courtCode, courtTeam, salesDetails, salesPictures
    case salesBuildings, salesItemDetails, conditionReport
    case appraisalDocumentUrl, appraisalDocuments, nearbySalesStats
    case soldOut = "isSoldOut"  
  }
  
  func toEntity() -> AuctionDetail {
    let itemTypes = self.itemTypes.compactMap { AuctionDetail.ItemType(rawValue: $0) }
    let bidType = AuctionDetail.BidType(rawValue: self.bidType)
    let salesDateTime = self.salesDateTime.toKoreanDate()
    let salesReceptionDate = self.salesReceptionDate.toKoreanDate()
    let salesOpenDate = self.salesOpenDate.toKoreanDate()
    let distributionRequiredDeadlineDate = self.distributionRequiredDeadlineDate.toKoreanDate()
    let salesCategories = self.salesCategories.compactMap { AuctionDetail.SalesCategory(rawValue: $0) }
    let courtCode = AuctionDetail.Court.CourtCode(rawValue: self.courtCode)
    let salesDetails = self.salesDetails.map { $0.toEntity() }
    let salesPictures = self.salesPictures.map { $0.toEntity() }
    let salesBuildings = self.salesBuildings.map { $0.toEntity() }
    let salesItemDetails = self.salesItemDetails.map { $0.toEntity() }
    let conditionReport = self.conditionReport.toEntity()
    let appraisalDocumentUrl = URL(string: self.appraisalDocumentUrl)
    let appraisalDocuments = self.appraisalDocuments.map { $0.toEntity() }
    let nearbySalesStats = self.nearbySalesStats.map { $0.toEntity() }
    
    return .init(
      id: id,
      salesNumber: salesNumber,
      itemTypes: itemTypes,
      appraisalPrice: appraisalPrice,
      lowestSalesPrice: lowestSalesPrice,
      bidType: bidType,
      salesDateTime: salesDateTime,
      salesLocation: salesLocation,
      salesNote: salesNote,
      salesReceptionDate: salesReceptionDate,
      salesOpenDate: salesOpenDate,
      distributionRequiredDeadlineDate: distributionRequiredDeadlineDate,
      salesAddress: salesAddress,
      salesCategories: salesCategories,
      failBidCount: failBidCount,
      zzimCount: zzimCount,
      court: .init(
        code: courtCode,
        team: courtTeam
      ),
      salesDetails: salesDetails,
      salesPictures: salesPictures,
      salesBuildings: salesBuildings,
      salesItemDetails: salesItemDetails,
      conditionReport: conditionReport,
      appraisalDocumentUrl: appraisalDocumentUrl,
      appraisalDocuments: appraisalDocuments,
      nearbySalesStats: nearbySalesStats,
      soldOut: soldOut
    )
  }
}

struct SalesDetailDTO: Decodable, Sendable {
  let timeStamp: String
  let type: String
  let location: String
  let leastSalesPrice: Int
  let result: String
  
  func toEntity() -> AuctionDetail.SalesDetail {
    return .init(
      timeStamp: AuctionDetailDTO.parseDate(from: timeStamp) ?? Date(timeIntervalSince1970: 0),
      type: AuctionDetail.SalesDetail.SalesDetailType(rawValue: type),
      location: location,
      leastSalesPrice: leastSalesPrice,
      result: AuctionDetail.SalesDetail.SalesResult(rawValue: result)
    )
  }
}

struct SalesBuildingDTO: Decodable, Sendable {
  let siDoAddressName: String
  let guAddressName: String
  let dongAddressName: String
  let riAddressName: String
  let fullAddressName: String
  let detailAddressName: String
  let category: String
  
  func toEntity() -> AuctionDetail.SalesBuilding {
    return .init(
      address: .init(
        siDo: siDoAddressName,
        gu: guAddressName,
        dong: dongAddressName,
        ri: riAddressName,
        full: fullAddressName
      ),
      detailAddress: detailAddressName,
      category: AuctionDetail.SalesBuilding.BuildingCategory(rawValue: category)
    )
  }
}

struct SalesItemDetailDTO: Decodable, Sendable {
  let sequence: Int
  let type: String
  let content: String
  
  func toEntity() -> AuctionDetail.SalesItemDetail {
    return .init(
      sequence: sequence,
      type: AuctionDetail.SalesItemDetail.ItemDetailType(rawValue: type),
      content: content
    )
  }
}

struct ConditionReportDTO: Decodable, Sendable {
  let investigationDate: String
  let estateLeaseInfos: [EstateLeaseInfoDTO]
  let occupationRelations: [OccupationRelationDTO]
  let occupationRelationReports: [OccupationRelationReportDTO]
  
  func toEntity() -> AuctionDetail.ConditionReport {
    return .init(
      investigationDate: AuctionDetailDTO.parseDate(from: investigationDate) ?? Date(timeIntervalSince1970: 0),
      estateLeaseInfos: estateLeaseInfos.map { $0.toEntity() },
      occupationRelations: occupationRelations.map { $0.toEntity() },
      occupationRelationReports: occupationRelationReports.map { $0.toEntity() }
    )
  }
}

struct EstateLeaseInfoDTO: Decodable, Sendable {
  let sequence: Int
  let address: String
  let leaseRelation: String
  
  func toEntity() -> AuctionDetail.ConditionReport.EstateLeaseInfo {
    return .init(
      sequence: sequence,
      address: address,
      leaseRelation: AuctionDetail.ConditionReport.EstateLeaseInfo.LeaseRelationType(rawValue: leaseRelation)
    )
  }
}

struct OccupationRelationDTO: Decodable, Sendable {
  let address: String
  let relation: String
  let etc: String
  
  func toEntity() -> AuctionDetail.ConditionReport.OccupationRelation {
    return .init(
      address: address,
      relation: relation,
      etc: etc
    )
  }
}

struct OccupationRelationReportDTO: Decodable, Sendable {
  let sequence: Int
  let address: String
  let occupant: String
  let relation: String
  let occupiedPart: String
  let purpose: String
  let duration: String
  let deposit: String
  let rental: String
  let movedAt: String
  let confirmedAt: String
  
  func toEntity() -> AuctionDetail.ConditionReport.OccupationRelationReport {
    return .init(
      sequence: sequence,
      address: address,
      occupant: occupant,
      relation: AuctionDetail.ConditionReport.OccupationRelationReport.OccupantRelation(rawValue: relation),
      occupiedPart: occupiedPart,
      purpose: AuctionDetail.ConditionReport.OccupationRelationReport.OccupationPurpose(rawValue: purpose),
      duration: duration,
      deposit: Int(deposit) ?? 0,
      rental: Int(rental) ?? 0,
      movedAt: AuctionDetailDTO.parseDate(from: movedAt) ?? Date(timeIntervalSince1970: 0),
      confirmedAt: AuctionDetailDTO.parseDate(from: confirmedAt) ?? Date(timeIntervalSince1970: 0)
    )
  }
}

struct AppraisalDocumentDTO: Decodable, Sendable {
  let sequence: Int
  let title: String
  let subTitle: String
  let content: String
  
  func toEntity() -> AuctionDetail.AppraisalDocument {
    return .init(
      sequence: sequence,
      title: title,
      subTitle: subTitle,
      content: content
    )
  }
}

struct NearbySalesStatDTO: Decodable, Sendable {
  let term: String
  let salesCount: Int
  let averageAppraisalPrice: Int
  let averageSalesPrice: Int
  let salesPriceRate: Double
  let averageFailBidCount: Double
  
  func toEntity() -> AuctionDetail.NearbySalesStat {
    return .init(
      term: Int(term) ?? 0,
      salesCount: salesCount,
      averageAppraisalPrice: averageAppraisalPrice,
      averageSalesPrice: averageSalesPrice,
      salesPriceRate: salesPriceRate,
      averageFailBidCount: averageFailBidCount
    )
  }
}

extension AuctionDetailDTO {
  fileprivate static func parseDate(from string: String) -> Date? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    if let date = isoFormatter.date(from: string) {
      return date
    }
    // Fallback without fractional seconds
    isoFormatter.formatOptions = [.withInternetDateTime]
    return isoFormatter.date(from: string)
  }
}
