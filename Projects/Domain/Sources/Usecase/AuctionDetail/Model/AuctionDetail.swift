//
//  AuctionDetail.swift
//  Domain
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

public struct AuctionDetail {
  public let id: Int
  public let salesNumber: String
  public let itemTypes: [ItemType]
  public let appraisalPrice: Int
  public let lowestSalesPrice: Int
  public let bidType: BidType
  public let salesDateTime: Date
  public let salesLocation: String
  public let salesNote: String
  public let salesReceptionDate: Date
  public let salesOpenDate: Date
  public let distributionRequiredDeadlineDate: Date
  public let salesAddress: String
  public let salesCategories: [SalesCategory]
  public let failBidCount: Int
  public let zzimCount: Int
  public let court: Court
  public let salesDetails: [SalesDetail]
  public let salesPictures: [SalesPicture]
  public let salesBuildings: [SalesBuilding]
  public let salesItemDetails: [SalesItemDetail]
  public let conditionReport: ConditionReport
  public let appraisalDocumentUrl: URL?
  public let appraisalDocuments: [AppraisalDocument]
  public let nearbySalesStats: [NearbySalesStat]
  public let soldOut: Bool
  
  public init(id: Int, salesNumber: String, itemTypes: [ItemType], appraisalPrice: Int, lowestSalesPrice: Int, bidType: BidType, salesDateTime: Date, salesLocation: String, salesNote: String, salesReceptionDate: Date, salesOpenDate: Date, distributionRequiredDeadlineDate: Date, salesAddress: String, salesCategories: [SalesCategory], failBidCount: Int, zzimCount: Int, court: Court, salesDetails: [SalesDetail], salesPictures: [SalesPicture], salesBuildings: [SalesBuilding], salesItemDetails: [SalesItemDetail], conditionReport: ConditionReport, appraisalDocumentUrl: URL?, appraisalDocuments: [AppraisalDocument], nearbySalesStats: [NearbySalesStat], soldOut: Bool) {
    self.id = id
    self.salesNumber = salesNumber
    self.itemTypes = itemTypes
    self.appraisalPrice = appraisalPrice
    self.lowestSalesPrice = lowestSalesPrice
    self.bidType = bidType
    self.salesDateTime = salesDateTime
    self.salesLocation = salesLocation
    self.salesNote = salesNote
    self.salesReceptionDate = salesReceptionDate
    self.salesOpenDate = salesOpenDate
    self.distributionRequiredDeadlineDate = distributionRequiredDeadlineDate
    self.salesAddress = salesAddress
    self.salesCategories = salesCategories
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
    self.court = court
    self.salesDetails = salesDetails
    self.salesPictures = salesPictures
    self.salesBuildings = salesBuildings
    self.salesItemDetails = salesItemDetails
    self.conditionReport = conditionReport
    self.appraisalDocumentUrl = appraisalDocumentUrl
    self.appraisalDocuments = appraisalDocuments
    self.nearbySalesStats = nearbySalesStats
    self.soldOut = soldOut
  }
  
  // MARK: - Enums
  public enum ItemType {
    case apartment
    case detachedHouse
    case multiHousehold
    case rowHouse
    case multiFamily
    case villa
    case automobile
    case heavyEquipment
    case land
    case forest
    case farmland
    case commercial
    case officeTel
    case neighborhoodFacility
    case other
    
    public init?(rawValue: String) {
      switch rawValue {
      case "APARTMENT": self = .apartment
      case "DETACHED_HOUSE": self = .detachedHouse
      case "MULTI_HOUSEHOLD": self = .multiHousehold
      case "ROW_HOUSE": self = .rowHouse
      case "MULTI_FAMILY": self = .multiFamily
      case "VILLA": self = .villa
      case "AUTOMOBILE": self = .automobile
      case "HEAVY_EQUIPMENT": self = .heavyEquipment
      case "LAND": self = .land
      case "FOREST": self = .forest
      case "FARMLAND": self = .farmland
      case "COMMERCIAL": self = .commercial
      case "OFFICE_TEL": self = .officeTel
      case "NEIGHBORHOOD_FACILITY": self = .neighborhoodFacility
      case "OTHER": self = .other
      default: return nil
      }
    }
  }
  
  public enum SalesCategory {
    case housing
    case villa
    case apartment
    case shopHouse
    case officetel
    case other
    
    public init?(rawValue: String) {
      switch rawValue {
      case "HOUSING": self = .housing
      case "VILLA": self = .villa
      case "APARTMENT": self = .apartment
      case "SHOP_HOUSE": self = .shopHouse
      case "OFFICETEL": self = .officetel
      case "OTHER": self = .other
      default: return nil
      }
    }
  }
  
  public enum BidType {
    case general
    case limited
    case other(String)
    
    public init(rawValue: String) {
      switch rawValue {
      case "일반입찰": self = .general
      case "제한입찰": self = .limited
      default: self = .other(rawValue)
      }
    }
  }
  
  // MARK: - Nested Structs
  public struct Court {
    let code: CourtCode
    let team: String
    
    public init(code: CourtCode, team: String) {
      self.code = code
      self.team = team
    }
    
    public enum CourtCode {
      case seoulCentralDistrict
      case seoulEasternDistrict
      case seoulWesternDistrict
      case seoulSouthernDistrict
      case seoulNorthernDistrict
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "SEOUL_CENTRAL_DISTRICT": self = .seoulCentralDistrict
        case "SEOUL_EASTERN_DISTRICT": self = .seoulEasternDistrict
        case "SEOUL_WESTERN_DISTRICT": self = .seoulWesternDistrict
        case "SEOUL_SOUTHERN_DISTRICT": self = .seoulSouthernDistrict
        case "SEOUL_NORTHERN_DISTRICT": self = .seoulNorthernDistrict
        default: self = .other(rawValue)
        }
      }
    }
  }
  
  public struct SalesDetail {
    public let timeStamp: Date
    public let type: SalesDetailType
    public let location: String
    public let leastSalesPrice: Int
    public let result: SalesResult
    
    public init(timeStamp: Date, type: SalesDetailType, location: String, leastSalesPrice: Int, result: SalesResult) {
      self.timeStamp = timeStamp
      self.type = type
      self.location = location
      self.leastSalesPrice = leastSalesPrice
      self.result = result
    }
    
    public enum SalesDetailType {
      case saleDate
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "매각기일": self = .saleDate
        default: self = .other(rawValue)
        }
      }
    }
    
    public enum SalesResult {
      case failedBid
      case sold
      case postponed
      case canceled
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "유찰": self = .failedBid
        case "낙찰": self = .sold
        case "연기": self = .postponed
        case "취소": self = .canceled
        default: self = .other(rawValue)
        }
      }
    }
  }
  
  public struct SalesPicture {
    public let sequence: Int
    public let imageUrl: URL?
    
    public init(sequence: Int, imageUrl: URL?) {
      self.sequence = sequence
      self.imageUrl = imageUrl
    }
  }
  
  public struct SalesBuilding {
    public let address: Address
    public let detailAddress: String
    public let category: BuildingCategory
    
    public init(address: Address, detailAddress: String, category: BuildingCategory) {
      self.address = address
      self.detailAddress = detailAddress
      self.category = category
    }
    
    public struct Address {
      public let siDo: String
      public let gu: String
      public let dong: String
      public let ri: String
      public let full: String
      
      public init(siDo: String, gu: String, dong: String, ri: String, full: String) {
        self.siDo = siDo
        self.gu = gu
        self.dong = dong
        self.ri = ri
        self.full = full
      }
    }
    
    public enum BuildingCategory {
      case exclusiveResidential
      case generalResidential
      case commercial
      case industrial
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "전용주거": self = .exclusiveResidential
        case "일반주거": self = .generalResidential
        case "상업": self = .commercial
        case "공업": self = .industrial
        default: self = .other(rawValue)
        }
      }
    }
  }
  
  public struct SalesItemDetail {
    public let sequence: Int
    public let type: ItemDetailType
    public let content: String
    
    public init(sequence: Int, type: ItemDetailType, content: String) {
      self.sequence = sequence
      self.type = type
      self.content = content
    }
    
    public enum ItemDetailType {
      case land
      case building
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "토지": self = .land
        case "건물": self = .building
        default: self = .other(rawValue)
        }
      }
    }
  }
  
  public struct ConditionReport {
    public let investigationDate: Date
    public let estateLeaseInfos: [EstateLeaseInfo]
    public let occupationRelations: [OccupationRelation]
    public let occupationRelationReports: [OccupationRelationReport]
    
    public init(investigationDate: Date, estateLeaseInfos: [EstateLeaseInfo], occupationRelations: [OccupationRelation], occupationRelationReports: [OccupationRelationReport]) {
      self.investigationDate = investigationDate
      self.estateLeaseInfos = estateLeaseInfos
      self.occupationRelations = occupationRelations
      self.occupationRelationReports = occupationRelationReports
    }
    
    public struct EstateLeaseInfo {
      public let sequence: Int
      public let address: String
      public let leaseRelation: LeaseRelationType
      
      public init(sequence: Int, address: String, leaseRelation: LeaseRelationType) {
        self.sequence = sequence
        self.address = address
        self.leaseRelation = leaseRelation
      }
      
      public enum LeaseRelationType {
        case tenant
        case landlord
        case other(String)
        
        public init(rawValue: String) {
          switch rawValue {
          case "임차인": self = .tenant
          case "임대인": self = .landlord
          default: self = .other(rawValue)
          }
        }
      }
    }
    
    public struct OccupationRelation {
      public let address: String
      public let relation: String
      public let etc: String
      
      public init(address: String, relation: String, etc: String) {
        self.address = address
        self.relation = relation
        self.etc = etc
      }
    }
    
    public struct OccupationRelationReport {
      public let sequence: Int
      public let address: String
      public let occupant: String
      public let relation: OccupantRelation
      public let occupiedPart: String
      public let purpose: OccupationPurpose
      public let duration: String
      public let deposit: Int
      public let rental: Int
      public let movedAt: Date
      public let confirmedAt: Date
      
      public init(sequence: Int, address: String, occupant: String, relation: OccupantRelation, occupiedPart: String, purpose: OccupationPurpose, duration: String, deposit: Int, rental: Int, movedAt: Date, confirmedAt: Date) {
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
      
      public enum OccupantRelation {
        case debtor
        case tenant
        case owner
        case other(String)
        
        public init(rawValue: String) {
          switch rawValue {
          case "채무자": self = .debtor
          case "임차인": self = .tenant
          case "소유자": self = .owner
          default: self = .other(rawValue)
          }
        }
      }
      
      public enum OccupationPurpose {
        case residential
        case commercial
        case office
        case other(String)
        
        public init(rawValue: String) {
          switch rawValue {
          case "주거": self = .residential
          case "상업": self = .commercial
          case "사무실": self = .office
          default: self = .other(rawValue)
          }
        }
      }
    }
  }
  
  public struct AppraisalDocument {
    public let sequence: Int
    public let title: String
    public let subTitle: String
    public let content: String
    
    public init(sequence: Int, title: String, subTitle: String, content: String) {
      self.sequence = sequence
      self.title = title
      self.subTitle = subTitle
      self.content = content
    }
  }
  
  public struct NearbySalesStat {
    public let term: Int  // months
    public let salesCount: Int
    public let averageAppraisalPrice: Int
    public let averageSalesPrice: Int
    public let salesPriceRate: Double  // percentage
    public let averageFailBidCount: Double
    
    public init(term: Int, salesCount: Int, averageAppraisalPrice: Int, averageSalesPrice: Int, salesPriceRate: Double, averageFailBidCount: Double) {
      self.term = term
      self.salesCount = salesCount
      self.averageAppraisalPrice = averageAppraisalPrice
      self.averageSalesPrice = averageSalesPrice
      self.salesPriceRate = salesPriceRate
      self.averageFailBidCount = averageFailBidCount
    }
  }
}

