//
//  Auction.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

public struct AuctionItem: Identifiable {
  public let id: Int
  public let courtName: String
  public let salesNumber: String
  public let salesSequence: Int
  public let salesType: String
  public let appraisalPrice: Int
  public let lowestSalesPrice: Int
  public let bidType: String
  public let salesDateTime: Date
  public let salesLocation: String
  public let salesNote: String
  public let salesReceptionDate: Date
  public let salesOpenDate: Date
  public let distributionRequiredDeadlineDate: Date
  public let claimPrice: Int
  public let appraisalDocumentUrl: URL
  public let createdAt: Date
  
  public let salesBuildings: [SalesBuilding]
  public let auctionDetails: [AuctionDetail]
  public let itemDetails: [ItemDetail]
  public let conditionReport: ConditionReport
  public let appraisalDocuments: [AppraisalDocument]
  public let nearbySalesStats: [NearbySalesStat]
  
  public init(
    id: Int,
    courtName: String,
    salesNumber: String,
    salesSequence: Int,
    salesType: String, // TODO: SalesType 모델 사용할 것 (API 완성되면)
    appraisalPrice: Int,
    lowestSalesPrice: Int,
    bidType: String, // TODO: BidType 모델 사용할 것 (API 완성되면)
    salesDateTime: Date,
    salesLocation: String,
    salesNote: String,
    salesReceptionDate: Date,
    salesOpenDate: Date,
    distributionRequiredDeadlineDate: Date,
    claimPrice: Int,
    appraisalDocumentUrl: URL,
    createdAt: Date,
    salesBuildings: [SalesBuilding],
    auctionDetails: [AuctionDetail],
    itemDetails: [ItemDetail],
    conditionReport: ConditionReport,
    appraisalDocuments: [AppraisalDocument],
    nearbySalesStats: [NearbySalesStat]
  ) {
    self.id = id
    self.courtName = courtName
    self.salesNumber = salesNumber
    self.salesSequence = salesSequence
    self.salesType = salesType
    self.appraisalPrice = appraisalPrice
    self.lowestSalesPrice = lowestSalesPrice
    self.bidType = bidType
    self.salesDateTime = salesDateTime
    self.salesLocation = salesLocation
    self.salesNote = salesNote
    self.salesReceptionDate = salesReceptionDate
    self.salesOpenDate = salesOpenDate
    self.distributionRequiredDeadlineDate = distributionRequiredDeadlineDate
    self.claimPrice = claimPrice
    self.appraisalDocumentUrl = appraisalDocumentUrl
    self.createdAt = createdAt
    self.salesBuildings = salesBuildings
    self.auctionDetails = auctionDetails
    self.itemDetails = itemDetails
    self.conditionReport = conditionReport
    self.appraisalDocuments = appraisalDocuments
    self.nearbySalesStats = nearbySalesStats
  }
}

public struct SalesBuilding {
  public let siDoAddressName: String
  public let guAddressName: String
  public let dongAddressName: String
  public let riAddressName: String
  public let fullAddressName: String
  public let detailAddressName: String
  public let category: String
  
  public init(siDoAddressName: String, guAddressName: String, dongAddressName: String, riAddressName: String, fullAddressName: String, detailAddressName: String, category: String) {
    self.siDoAddressName = siDoAddressName
    self.guAddressName = guAddressName
    self.dongAddressName = dongAddressName
    self.riAddressName = riAddressName
    self.fullAddressName = fullAddressName
    self.detailAddressName = detailAddressName
    self.category = category
  }
}

public struct ItemDetail {
  let sequence: Int
  let type: String
  let content: String
  
  public init(sequence: Int, type: String, content: String) {
    self.sequence = sequence
    self.type = type
    self.content = content
  }
}

public struct AuctionDetail {
  let timeStamp: AuctionTime
  let type: String
  let location: String
  let leastSalesPrice: Int?
  let result: String
  
  public init(timeStamp: AuctionTime, type: String, location: String, leastSalesPrice: Int?, result: String) {
    self.timeStamp = timeStamp
    self.type = type
    self.location = location
    self.leastSalesPrice = leastSalesPrice
    self.result = result
  }
}

public struct AuctionTime {
  let year: Int
  let monthValue: Int
  let dayOfMonth: Int
  let hour: Int
  let minute: Int
  let second: Int
  
  public init(year: Int, monthValue: Int, dayOfMonth: Int, hour: Int, minute: Int, second: Int) {
    self.year = year
    self.monthValue = monthValue
    self.dayOfMonth = dayOfMonth
    self.hour = hour
    self.minute = minute
    self.second = second
  }
}

public struct ConditionReport {
  let caseNumber: String
  let investigationDate: String
  let estateLeaseInfos: [LeaseInfo]
  let occupationRelations: [OccupationRelation]
  let occupationRelationReports: [OccupationRelationReport]
  
  public init(caseNumber: String, investigationDate: String, estateLeaseInfos: [LeaseInfo], occupationRelations: [OccupationRelation], occupationRelationReports: [OccupationRelationReport]) {
    self.caseNumber = caseNumber
    self.investigationDate = investigationDate
    self.estateLeaseInfos = estateLeaseInfos
    self.occupationRelations = occupationRelations
    self.occupationRelationReports = occupationRelationReports
  }
}

public struct LeaseInfo {
  let sequence: Int
  let address: String
  let leaseRelation: String
  
  public init(sequence: Int, address: String, leaseRelation: String) {
    self.sequence = sequence
    self.address = address
    self.leaseRelation = leaseRelation
  }
}

public struct OccupationRelation {
  let address: String
  let relation: String
  let etc: String
  
  public init(address: String, relation: String, etc: String) {
    self.address = address
    self.relation = relation
    self.etc = etc
  }
}

public struct OccupationRelationReport {
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
  
  public init(sequence: Int, address: String, occupant: String, relation: String, occupiedPart: String, purpose: String, duration: String, deposit: String, rental: String, movedAt: String, confirmedAt: String) {
    self.sequence = sequence
    self.address = address
    self.occupant = occupant
    self.relation = relation
    self.occupiedPart = occupiedPart
    self.purpose = purpose
    self.duration = duration
    self.deposit = deposit
    self.rental = rental
    self.movedAt = movedAt
    self.confirmedAt = confirmedAt
  }
}

public struct AppraisalDocument {
  let sequence: Int
  let documentTitle: String
  let subTitle: String
  let content: String
  
  public init(sequence: Int, documentTitle: String, subTitle: String, content: String) {
    self.sequence = sequence
    self.documentTitle = documentTitle
    self.subTitle = subTitle
    self.content = content
  }
}

public struct NearbySalesStat {
  let term: Int
  let salesCount: Int
  let averageAppraisalPrice: Int
  let averageSalesPrice: Int
  let salesPriceRate: Double
  let averageFailBidCount: Double
  
  public init(term: Int, salesCount: Int, averageAppraisalPrice: Int, averageSalesPrice: Int, salesPriceRate: Double, averageFailBidCount: Double) {
    self.term = term
    self.salesCount = salesCount
    self.averageAppraisalPrice = averageAppraisalPrice
    self.averageSalesPrice = averageSalesPrice
    self.salesPriceRate = salesPriceRate
    self.averageFailBidCount = averageFailBidCount
  }
}

