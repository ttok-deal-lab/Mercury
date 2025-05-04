//
//  AuctionItemDTO.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

struct AuctionItemDTO: Decodable {
  let id: Int
  let courtName: String
  let salesNumber: String
  let salesSequence: Int
  let salesType: String
  let appraisalPrice: Int
  let lowestSalesPrice: Int
  let bidType: String
  let salesDateTime: Date
  let salesLocation: String
  let salesNote: String
  let salesReceptionDate: Date
  let salesOpenDate: Date
  let distributionRequiredDeadlineDate: Date
  let claimPrice: Int
  let appraisalDocumentUrl: URL
  let createdAt: Date
  
  let salesBuildings: [SalesBuildingDTO]
  let auctionDetails: [AuctionDetailDTO]
  let itemDetails: [ItemDetailDTO]
  let conditionReport: ConditionReportDTO
  let appraisalDocuments: [AppraisalDocumentDTO]
  let nearbySalesStats: [NearbySalesStatDTO]
  
  func toAuctionItem() -> AuctionItem {
    return .init(
      id: id,
      courtName: courtName,
      salesNumber: salesNumber,
      salesSequence: salesSequence,
      salesType: salesType,
      appraisalPrice: appraisalPrice,
      lowestSalesPrice: lowestSalesPrice,
      bidType: bidType,
      salesDateTime: salesDateTime,
      salesLocation: salesLocation,
      salesNote: salesNote,
      salesReceptionDate: salesReceptionDate,
      salesOpenDate: salesOpenDate,
      distributionRequiredDeadlineDate: distributionRequiredDeadlineDate,
      claimPrice: claimPrice,
      appraisalDocumentUrl: appraisalDocumentUrl,
      createdAt: createdAt,
      salesBuildings: salesBuildings
        .map {
          SalesBuilding(
            siDoAddressName: $0.siDoAddressName,
            guAddressName: $0.guAddressName,
            dongAddressName: $0.dongAddressName,
            riAddressName: $0.riAddressName,
            fullAddressName: $0.fullAddressName,
            detailAddressName: $0.detailAddressName,
            category: $0.category
          )
        },
      auctionDetails: auctionDetails
        .map {
          AuctionDetail(
            timeStamp: AuctionTime(
              year: $0.timeStamp.year,
              monthValue: $0.timeStamp.monthValue,
              dayOfMonth: $0.timeStamp.dayOfMonth,
              hour: $0.timeStamp.hour,
              minute: $0.timeStamp.minute,
              second: $0.timeStamp.second
            ),
            type: $0.type,
            location: $0.location,
            leastSalesPrice: $0.leastSalesPrice,
            result: $0.result
          )
        },
      itemDetails: itemDetails
        .map {
          ItemDetail(
            sequence: $0.sequence,
            type: $0.type,
            content: $0.content
          )
        },
      conditionReport: ConditionReport(
        caseNumber: conditionReport.caseNumber,
        investigationDate: conditionReport.investigationDate,
        estateLeaseInfos: conditionReport.estateLeaseInfos.map {
          LeaseInfo(
            sequence: $0.sequence,
            address: $0.address,
            leaseRelation: $0.leaseRelation
          )
        },
        occupationRelations: conditionReport.occupationRelations
          .map {
            OccupationRelation(
              address: $0.address,
              relation: $0.relation,
              etc: $0.etc
            )
          },
        occupationRelationReports: conditionReport.occupationRelationReports
          .map {
            OccupationRelationReport(
              sequence: $0.sequence,
              address: $0.address,
              occupant: $0.occupant,
              relation: $0.relation,
              occupiedPart: $0.occupiedPart,
              purpose: $0.purpose,
              duration: $0.duration,
              deposit: $0.deposit,
              rental: $0.rental,
              movedAt: $0.movedAt,
              confirmedAt: $0.confirmedAt
            )
          }
      ),
      appraisalDocuments: appraisalDocuments
        .map {
          AppraisalDocument(
            sequence: $0.sequence,
            documentTitle: $0.documentTitle,
            subTitle: $0.subTitle,
            content: $0.content
          )
        },
      nearbySalesStats: nearbySalesStats
        .map {
          NearbySalesStat(
            term: $0.term,
            salesCount: $0.salesCount,
            averageAppraisalPrice: $0.averageAppraisalPrice,
            averageSalesPrice: $0.averageSalesPrice,
            salesPriceRate: $0.salesPriceRate,
            averageFailBidCount: $0.averageFailBidCount
          )
        }
    )
  }
  
  enum CodingKeys: String, CodingKey {
    case id, courtName, salesNumber, salesSequence, salesType, appraisalPrice, lowestSalesPrice, bidType, salesDateTime, salesLocation, salesNote, salesReceptionDate, salesOpenDate, distributionRequiredDeadlineDate, claimPrice, appraisalDocumentUrl, createdAt
    case salesBuildingsJson, auctionDetailsJson, itemDetailsJson, conditionReportJson, appraisalDocumentsJson, nearbySalesStatsJson
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    courtName = try container.decode(String.self, forKey: .courtName)
    salesNumber = try container.decode(String.self, forKey: .salesNumber)
    salesSequence = try container.decode(Int.self, forKey: .salesSequence)
    salesType = try container.decode(String.self, forKey: .salesType)
    appraisalPrice = try container.decode(Int.self, forKey: .appraisalPrice)
    lowestSalesPrice = try container.decode(Int.self, forKey: .lowestSalesPrice)
    bidType = try container.decode(String.self, forKey: .bidType)
    salesLocation = try container.decode(String.self, forKey: .salesLocation)
    salesNote = try container.decode(String.self, forKey: .salesNote)
    claimPrice = try container.decode(Int.self, forKey: .claimPrice)
    appraisalDocumentUrl = try container.decode(URL.self, forKey: .appraisalDocumentUrl)
    
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime]
    
    salesDateTime = try isoFormatter.decode(from: container, key: .salesDateTime)
    salesReceptionDate = try isoFormatter.decode(from: container, key: .salesReceptionDate)
    salesOpenDate = try isoFormatter.decode(from: container, key: .salesOpenDate)
    distributionRequiredDeadlineDate = try isoFormatter.decode(from: container, key: .distributionRequiredDeadlineDate)
    createdAt = try isoFormatter.decode(from: container, key: .createdAt)
    
    let salesBuildingsString = try container.decode(String.self, forKey: .salesBuildingsJson)
    salesBuildings = try JSONDecoder().decode([SalesBuildingDTO].self, from: Data(salesBuildingsString.utf8))
    
    let auctionDetailsString = try container.decode(String.self, forKey: .auctionDetailsJson)
    auctionDetails = try JSONDecoder().decode([AuctionDetailDTO].self, from: Data(auctionDetailsString.utf8))
    
    let itemDetailsString = try container.decode(String.self, forKey: .itemDetailsJson)
    itemDetails = try JSONDecoder().decode([ItemDetailDTO].self, from: Data(itemDetailsString.utf8))
    
    let conditionReportString = try container.decode(String.self, forKey: .conditionReportJson)
    conditionReport = try JSONDecoder().decode(ConditionReportDTO.self, from: Data(conditionReportString.utf8))
    
    let appraisalDocumentsString = try container.decode(String.self, forKey: .appraisalDocumentsJson)
    appraisalDocuments = try JSONDecoder().decode([AppraisalDocumentDTO].self, from: Data(appraisalDocumentsString.utf8))
    
    let nearbyStatsString = try container.decode(String.self, forKey: .nearbySalesStatsJson)
    nearbySalesStats = try JSONDecoder().decode([NearbySalesStatDTO].self, from: Data(nearbyStatsString.utf8))
  }
}

struct SalesBuildingDTO: Decodable {
  let siDoAddressName: String
  let guAddressName: String
  let dongAddressName: String
  let riAddressName: String
  let fullAddressName: String
  let detailAddressName: String
  let category: String
}

struct AuctionDetailDTO: Decodable {
  let timeStamp: AuctionTimeDTO
  let type: String
  let location: String
  let leastSalesPrice: Int?
  let result: String
}

struct AuctionTimeDTO: Decodable {
  let year: Int
  let monthValue: Int
  let dayOfMonth: Int
  let hour: Int
  let minute: Int
  let second: Int
}


struct ItemDetailDTO: Decodable {
  let sequence: Int
  let type: String
  let content: String
}

struct ConditionReportDTO: Decodable {
  let caseNumber: String
  let investigationDate: String
  let estateLeaseInfos: [LeaseInfoDTO]
  let occupationRelations: [OccupationRelationDTO]
  let occupationRelationReports: [OccupationRelationReportDTO]
}

struct LeaseInfoDTO: Decodable {
  let sequence: Int
  let address: String
  let leaseRelation: String
}

struct OccupationRelationDTO: Decodable {
  let address: String
  let relation: String
  let etc: String
}

struct OccupationRelationReportDTO: Decodable {
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
}

struct AppraisalDocumentDTO: Decodable {
  let sequence: Int
  let documentTitle: String
  let subTitle: String
  let content: String
}

struct NearbySalesStatDTO: Decodable {
  let term: Int
  let salesCount: Int
  let averageAppraisalPrice: Int
  let averageSalesPrice: Int
  let salesPriceRate: Double
  let averageFailBidCount: Double
}
