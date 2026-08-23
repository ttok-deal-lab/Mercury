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
  let court: CourtDTO
  let salesDetails: [SalesDetailDTO]
  let salesPictures: [SalesPictureDTO]
  let salesBuildings: [SalesBuildingDTO]
  let salesItemDetails: [SalesItemDetailDTO]
  let conditionReport: ConditionReportDTO
  let appraisalDocumentUrl: String
  let appraisalDocuments: [AppraisalDocumentDTO]
  let nearbySalesStats: [NearbySalesStatDTO]
  let soldOut: Bool
  let verified: Bool
  let salesBuildingName: String
  let exclusiveArea: Double
  let caseName: String
  let creditorCount: Int
  let recentTransactionPrice: Int
  let recentTransactionDate: String
  let rightsAnalysis: [RightsAnalysisDTO]

  enum CodingKeys: String, CodingKey {
    case id, salesNumber, itemTypes, appraisalPrice, lowestSalesPrice
    case bidType, salesDateTime, salesLocation, salesNote
    case salesReceptionDate, salesOpenDate, distributionRequiredDeadlineDate
    case salesAddress, salesCategories, failBidCount, zzimCount
    case courtCode, courtTeam, court, salesDetails, salesPictures
    case salesBuildings, salesItemDetails, conditionReport
    case appraisalDocumentUrl, appraisalDocuments, nearbySalesStats
    case soldOut = "isSoldOut"
    case verified, salesBuildingName, exclusiveArea, caseName, creditorCount
    case recentTransactionPrice, recentTransactionDate, rightsAnalysis
  }
  
  func toEntity() -> AuctionDetail {
    let itemTypes = self.itemTypes.compactMap { AuctionDetail.ItemType(rawValue: $0) }
    let bidType = AuctionDetail.BidType(rawValue: self.bidType)
    let salesDateTime = self.salesDateTime.toKoreanDate()
    let salesReceptionDate = self.salesReceptionDate.toKoreanDate()
    let salesOpenDate = self.salesOpenDate.toKoreanDate()
    let distributionRequiredDeadlineDate = self.distributionRequiredDeadlineDate.toKoreanDate()
    let salesCategories = self.salesCategories.map { AuctionDetail.SalesCategory(rawValue: $0) }
    let courtCode = AuctionDetail.Court.CourtCode(rawValue: self.courtCode)
    let courtInfo = self.court.toEntity()
    let salesDetails = self.salesDetails.map { $0.toEntity() }
    let salesPictures = self.salesPictures.map { $0.toEntity() }
    let salesBuildings = self.salesBuildings.map { $0.toEntity() }
    let salesItemDetails = self.salesItemDetails.map { $0.toEntity() }
    let conditionReport = self.conditionReport.toEntity()
    let appraisalDocumentUrl = URL(string: self.appraisalDocumentUrl)
    let appraisalDocuments = self.appraisalDocuments.map { $0.toEntity() }
    let nearbySalesStats = self.nearbySalesStats.map { $0.toEntity() }
    let recentTransactionPrice: Int? =
      self.recentTransactionPrice == Self.noDataPrice ? nil : self.recentTransactionPrice
    let recentTransactionDate = Self.parseDateOnly(from: self.recentTransactionDate)
    let rightsAnalysis = self.rightsAnalysis.map { $0.toEntity() }

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
      courtInfo: courtInfo,
      salesDetails: salesDetails,
      salesPictures: salesPictures,
      salesBuildings: salesBuildings,
      salesItemDetails: salesItemDetails,
      conditionReport: conditionReport,
      appraisalDocumentUrl: appraisalDocumentUrl,
      appraisalDocuments: appraisalDocuments,
      nearbySalesStats: nearbySalesStats,
      soldOut: soldOut,
      verified: verified,
      salesBuildingName: salesBuildingName,
      exclusiveArea: exclusiveArea,
      caseName: caseName,
      creditorCount: creditorCount,
      recentTransactionPrice: recentTransactionPrice,
      recentTransactionDate: recentTransactionDate,
      rightsAnalysis: rightsAnalysis
    )
  }
}

struct CourtDTO: Decodable, Sendable {
  let code: String
  let name: String
  let address: String
  let latitude: Double?
  let longitude: Double?

  func toEntity() -> AuctionDetail.CourtInfo {
    return .init(
      code: code,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude
    )
  }
}

struct SalesDetailDTO: Decodable, Sendable {
  let timeStamp: String
  let type: String
  let location: String
  // 최고가매각불허가결정(BEST_BID_REJECTED) 등 최저가가 없는 기일은 null 로 내려온다.
  // 비옵셔널로 두면 이 항목 하나 때문에 상세 응답 전체 디코딩이 실패한다.
  let leastSalesPrice: Int?
  let result: String
  
  func toEntity() -> AuctionDetail.SalesDetail {
    return .init(
      timeStamp: AuctionDetailDTO.parseDate(from: timeStamp),
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
  let latitude: Double?
  let longitude: Double?

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
      category: AuctionDetail.SalesBuilding.BuildingCategory(rawValue: category),
      latitude: latitude,
      longitude: longitude
    )
  }
}

struct RightsAnalysisDTO: Decodable, Sendable {
  let name: String
  let role: String
  let hasOppositionRight: String
  let moveInReportDate: String
  let occupationStatus: String
  let priorityRepaymentRight: String
  let fixedDate: String
  let dividendRequest: String
  let dividendRequestDate: String
  let deposit: Int
  let monthlyRent: Int

  func toEntity() -> AuctionDetail.RightsAnalysis {
    return .init(
      name: name,
      role: role,
      hasOppositionRight: hasOppositionRight,
      moveInReportDate: moveInReportDate,
      occupationStatus: occupationStatus,
      priorityRepaymentRight: priorityRepaymentRight,
      fixedDate: fixedDate,
      dividendRequest: dividendRequest,
      dividendRequestDate: dividendRequestDate,
      deposit: deposit,
      monthlyRent: monthlyRent
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
      investigationDate: AuctionDetailDTO.parseDate(from: investigationDate),
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
      movedAt: AuctionDetailDTO.parseDate(from: movedAt),
      confirmedAt: AuctionDetailDTO.parseDate(from: confirmedAt)
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
  /// 서버가 "데이터 없음"을 나타내는 가격 센티넬
  fileprivate static let noDataPrice = -999999999

  /// 날짜만 있는 문자열(yyyy-MM-dd) 파싱. 유효하지 않으면 nil ("2026-99-99" 등)
  fileprivate static func parseDateOnly(from string: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.isLenient = false
    return formatter.date(from: string)
  }

  /// 날짜+시간 문자열 파싱. 유효하지 않으면 nil.
  ///
  /// 서버는 기일/조사일자를 ISO8601 이 아닌 `"2026-09-01 14:00:00"` (T 구분자·타임존 오프셋 없음) 형태로 내려준다.
  /// ISO8601DateFormatter 만 쓰면 전부 nil 이 되므로 공백 구분 포맷까지 순차적으로 시도한다.
  fileprivate static func parseDate(from string: String) -> Date? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    if let date = isoFormatter.date(from: string) {
      return date
    }
    // Fallback without fractional seconds
    isoFormatter.formatOptions = [.withInternetDateTime]
    if let date = isoFormatter.date(from: string) {
      return date
    }

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.isLenient = false
    for format in ["yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd"] {
      formatter.dateFormat = format
      if let date = formatter.date(from: string) {
        return date
      }
    }
    return nil
  }
}
